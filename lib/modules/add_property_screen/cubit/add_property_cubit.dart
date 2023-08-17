import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/shared/models/store_property_model.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/services/properties/store_property_service.dart';
import '../../../shared/functions/custom_snack_bar.dart';
import '../../../shared/models/governorate_model.dart';
import '../../../shared/models/region_model.dart';
import '../../../shared/network/remote/services/constants/get_governorates_regions_service.dart';
import '../../../shared/network/remote/services/constants/get_governorates_service.dart';
import 'add_property_states.dart';

class AddPropertyCubit extends Cubit<AddPropertyStates> {
  AddPropertyCubit() : super(AddPropertyInitial());

  StorePropertyModel? storePropertyModel;
  final formKey = GlobalKey<FormState>();

  List<GovernorateModel> governorates = [];
  List<RegionModel> regions = [];
  GovernorateModel? selctedGovernorate;
  RegionModel? selectedRegion;
  bool governoratesLoading = false;
  bool regionsLoading = false;

  List<String> selectedImagesList = [];
  int selectedTypeIndex = 0;
  PageController controller = PageController(initialPage: 0);

  Map<String, bool> farm = {
    'isGarden': false,
    'isBabyPool': false,
    'isBar': false,
  };

  // List<RegionModel> locations = [
  //   RegionModel(id: 1, x: 1.3213613636, y: 1.654643, name: "a"),
  //   RegionModel(id: 2, x: 1.357575, y: 1.6798724123, name: "b"),
  //   RegionModel(id: 3, x: 1.3213613636, y: 1.12354643, name: "c"),
  //   RegionModel(id: 4, x: 1.3213613636, y: 1.5758743, name: "d"),
  // ];

  List<String> types = ['House', 'Farm', 'Market'];
  Map<String, bool> directions = {
    'North': false,
    'South': false,
    'West': false,
    'East': false,
  };

  void selectDirections(int index) {
    // log(directions[directions.keys.elementAt(index)].toString());
    emit(AddPropertyInitial());
    if (directions[directions.keys.elementAt(index)] == true) {
      directions[directions.keys.elementAt(index)] = false;
      // // if (direction.trim().isEmpty) {
      // //   direction = '';
      // } else {
      //   direction = direction.replaceAll(
      //     directions.keys.elementAt(index),
      //     '',
      //   );
      // }
    } else {
      directions[directions.keys.elementAt(index)] = true;
      // if (direction == '') {
      //   direction = directions.keys.elementAt(index);
      // } else {
      //   direction = '$direction ${directions.keys.elementAt(index)}';
      // }
    }
    emit(SelectTypeState());
  }

  bool chackDirections() {
    bool val = false;
    directions.forEach((key, value) {
      if (value) {
        val = true;
      }
    });
    return val;
  }

  void selectFarmDetails(int index) {
    // log(farm[farm.keys.elementAt(index)].toString());
    emit(AddPropertyInitial());
    if (farm[farm.keys.elementAt(index)] == true) {
      farm[farm.keys.elementAt(index)] = false;
    } else {
      farm[farm.keys.elementAt(index)] = true;
    }
    emit(SelectTypeState());
  }

  void removeSelectedItem({required String helper}) {
    emit(AddPropertyInitial());
    if (helper == 'G') {
      selctedGovernorate = null;
    } else {
      selectedRegion = null;
    }
    emit(SelectItemState());
  }

  void deleteImageFromList({required int imageIndex}) {
    emit(AddPropertyInitial());
    selectedImagesList.removeAt(imageIndex);
    emit(AddImagesState());
  }

  void selectPropertyType(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
    emit(AddPropertyInitial());
    selectedTypeIndex = index;
    emit(SelectTypeState());
  }

  Future<void> selectimages() async {
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile> selectedimages = await imagePicker.pickMultiImage();
    try {
      emit(AddPropertyInitial());
      if (selectedimages.isNotEmpty) {
        for (var element in selectedimages) {
          selectedImagesList.add(element.path);
        }
      } else {
        selectedImagesList.clear();
      }
      emit(AddImagesState());
    } on PlatformException catch (ex) {
      log(ex.toString());
    }
  }

  Future<void> getGovernorates() async {
    emit(FetchItemsLoading());
    governoratesLoading = true;
    (await GetGovernoratesService.getGovernorates()).fold(
      (failure) {
        emit(AddPropertyFailure(failureMsg: failure.errorMessege));
      },
      (governorates) {
        this.governorates = governorates;
        governoratesLoading = false;
        emit(AddPropertyInitial());
      },
    );
  }

  Future<void> getGovernorateRegions(BuildContext context) async {
    if (selctedGovernorate != null) {
      emit(FetchItemsLoading());
      regionsLoading = true;
      (await GetGovernoratesRegionsService.getGovernoratesRegions(
              governorateID: selctedGovernorate!.id))
          .fold(
        (failure) {
          emit(AddPropertyFailure(failureMsg: failure.errorMessege));
        },
        (regions) {
          this.regions.clear();
          this.regions = regions;
          regionsLoading = false;
          emit(AddPropertyInitial());
        },
      );
    } else {
      CustomeSnackBar.showSnackBar(
        context,
        msg: 'Please Select Governorate First',
        color: Colors.red,
      );
    }
  }

  void selectGovernorate({required int index}) {
    if (governorates.isNotEmpty) {
      emit(AddPropertyInitial());
      selctedGovernorate = governorates[index];
      emit(SelectItemState());
    }
  }

  void selectRegion({required int index}) {
    if (regions.isNotEmpty) {
      emit(AddPropertyInitial());
      selectedRegion = regions[index];
      emit(SelectItemState());
    }
  }

  int? numOfRooms, numOfBathrooms, numOfBalcony, price, space, numOfPools;
  double? x, y;
  String? description;
  String direction = '';

  Future<void> storeProperty() async {
    emit(AddPropertyLoading());
    if (selectedTypeIndex == 0) {
      directions.forEach((key, value) {
        if (value) {
          if (direction.isNotEmpty) {
            direction = '$direction - $key';
          } else {
            direction = key;
          }
        }
      });
      storePropertyModel = StoreHouseModel(
        numOfRooms: numOfRooms!,
        numOfBathrooms: numOfBathrooms!,
        numOfBalcony: numOfBalcony!,
        direction: direction,
        description: description!,
        price: price!,
        space: space!,
        regionID: selectedRegion!.id,
        propertyTypeID: selectedTypeIndex + 1,
        x: x!,
        y: y!,
      );
    } else if (selectedTypeIndex == 1) {
      storePropertyModel = StoreFarmModel(
        numOfRooms: numOfRooms!,
        numOfPools: numOfPools!,
        isGarden: farm['isGarden']!,
        isBar: farm['isBar']!,
        isBabyPool: farm['isBabyPool']!,
        description: description!,
        price: price!,
        space: space!,
        regionID: selectedRegion!.id,
        propertyTypeID: selectedTypeIndex + 1,
        x: x!,
        y: y!,
      );
    } else {
      storePropertyModel = StoreMarketModel(
        price: price!,
        space: space!,
        regionID: selectedRegion!.id,
        propertyTypeID: selectedTypeIndex + 1,
        x: x!,
        y: y!,
        description: description!,
      );
    }
    (await StorePropertyService.storeProperty(
      storePropertyModel: storePropertyModel!,
      images: selectedImagesList,
      token: await CacheHelper.getData(key: 'Token'),
    ))
        .fold(
      (failure) {
        emit(AddPropertyFailure(failureMsg: failure.errorMessege));
      },
      (success) {
        emit(AddPropertySuccess());
      },
    );
  }
}
