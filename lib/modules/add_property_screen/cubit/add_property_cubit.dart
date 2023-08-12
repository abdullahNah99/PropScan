import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/functions/custom_snack_bar.dart';
import '../../../shared/models/governorate_model.dart';
import '../../../shared/models/region_model.dart';
import '../../../shared/network/remote/services/constants/get_governorates_regions_service.dart';
import '../../../shared/network/remote/services/constants/get_governorates_service.dart';
import 'add_property_states.dart';

class AddPropertyCubit extends Cubit<AddPropertyStates> {
  AddPropertyCubit() : super(AddPropertyInitial());

  List<GovernorateModel> governorates = [];
  List<RegionModel> regions = [];
  GovernorateModel? selctedGovernorate;
  RegionModel? selectedRegion;
  bool governoratesLoading = false;
  bool regionsLoading = false;
  List<RegionModel> locations = [
    RegionModel(id: 1, x: 1.3213613636, y: 1.654643, name: "a"),
    RegionModel(id: 2, x: 1.357575, y: 1.6798724123, name: "b"),
    RegionModel(id: 3, x: 1.3213613636, y: 1.12354643, name: "c"),
    RegionModel(id: 4, x: 1.3213613636, y: 1.5758743, name: "d"),
  ];

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
}
