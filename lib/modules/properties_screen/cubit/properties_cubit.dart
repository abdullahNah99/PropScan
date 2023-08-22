import 'package:awesome_icons/awesome_icons.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_states.dart';
import 'package:untitled/shared/models/firebase_models/chat_user.dart';
import 'package:untitled/shared/network/remote/firebase/firebase_apis.dart';
import 'package:untitled/shared/network/remote/services/auth/logout_service.dart';
import 'package:untitled/shared/network/remote/services/properties/index_properties_service.dart';
import 'package:untitled/shared/network/remote/services/properties/show_all_preoperties_service.dart';
import '../../../shared/functions/custom_snack_bar.dart';
import '../../../shared/models/property_model.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../login_screen/login_screen.dart';

class PropertiesCubit extends Cubit<PropertiesStates> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ChatUser? chatUser;
  List<PropertyModel> properties = [];
  //////////////////////////////////////////////////////////
  List<PropertyModel> nearestProps = [];
  int bottomNavigationBarIndex = 0;
  // double? myX;
  // double? myY;

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.map),
      label: 'Map',
    ),
  ];

  void changeBottomNavigationBarIndex(int index) {
    emit(PropertiesInitial());
    bottomNavigationBarIndex = index;
    emit(ChangeBottomNavigationBarIndex());
  }

  Future<Position> getMyLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // .then(
    //   (position) {
    //     myX = position.latitude;
    //     myY = position.longitude;
    //   },
    // );
  }

  double getDistance({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    return (Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000);
  }

  Future<void> getNearestProperties() async {
    await getMyLocation().then(
      (position) async {
        (await IndexPropertiesService.indexProperties(
          x: position.latitude,
          y: position.longitude,
          token: await CacheHelper.getData(key: 'Token'),
        ))
            .fold(
          (failure) {
            emit(PropertiesFailure(errorMessage: failure.errorMessege));
          },
          (nearestProps) {
            this.nearestProps.clear();
            this.nearestProps.add(
                  PropertyModel(
                    id: -1,
                    price: 0,
                    space: 0,
                    state: '',
                    governorate: '',
                    region: '',
                    type: '',
                    x: position.latitude,
                    y: position.longitude,
                    images: [],
                    userId: 0,
                    isFoveate: false,
                  ),
                );
            for (PropertyModel item in nearestProps) {
              if (getDistance(
                      lat1: position.latitude,
                      lon1: position.longitude,
                      lat2: item.x,
                      lon2: item.y) <
                  4) {
                this.nearestProps.add(item);
              } else {
                break;
              }
            }
          },
        );
      },
    );
  }
  //////////////////////////////////////////////////////////////////////////

  PropertiesCubit() : super(PropertiesInitial());

  Future<void> logOut(BuildContext context) async {
    emit(PropertiesLoading());
    await FirebaseAPIs.auth.signOut().then(
      (value) async {
        (await LogOutService.logout(
          token: await CacheHelper.getData(key: 'Token'),
        ))
            .fold(
          (failure) {
            CustomeSnackBar.showSnackBar(
              context,
              msg: 'Something Went Wrong, Please Try Again',
              color: Colors.red,
            );
          },
          (success) async {
            await CacheHelper.deletData(key: 'Token');
            // ignore: use_build_context_synchronously
            Navigator.popAndPushNamed(context, LoginView.route);
          },
        );
      },
    );
  }

  Future<void> getPropertyChatUser({required int localUserID}) async {
    emit(PropertiesLoading());
    try {
      FirebaseAPIs.firesotre
          .collection('users')
          .where('local_user_id', isEqualTo: localUserID)
          .snapshots()
          .listen((event) {
        emit(GetPropertyChatUserSuccess(
            chatUser: ChatUser.factory(event.docs[0].data())));
      });
    } catch (ex) {
      emit(PropertiesFailure(errorMessage: ex.toString()));
    }
  }

  Future<void> getAllProperties() async {
    emit(PropertiesLoading());
    (await ShowAllPropertiesService.showAll(
      token: await CacheHelper.getData(key: "Token"),
    ))
        .fold(
      (failure) {
        emit(
          PropertiesFailure(errorMessage: failure.errorMessege),
        );
      },
      (properties1) {
        // properties = properties1;
        emit(
          PropertiesSuccess(properties: properties1),
        );
      },
    );
  }

  void changeIsFoveate({required PropertyModel properties}) {
    emit(PropertiesInitial());
    properties.isFoveate = !properties.isFoveate;
    emit(ChangeIsFoveateSuccess(isFoveate: properties.isFoveate));
  }
}
