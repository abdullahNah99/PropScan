// import 'package:awesome_icons/awesome_icons.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:untitled/modules/google_map_screen/google_map_screen.dart';
// import 'package:untitled/modules/properties_screen/properties_screen.dart';
// import 'package:untitled/shared/models/region_model.dart';
// import 'package:untitled/shared/network/local/cache_helper.dart';
// import 'package:untitled/shared/network/remote/services/properties/show_all_preoperties_service.dart';

// part 'home_state.dart';

// class HomeCubit extends Cubit<HomeState> {
//   HomeCubit() : super(HomeInitial());

//   int index = 0;
//   double? myX;
//   double? myY;

//   List<BottomNavigationBarItem> items = [
//     const BottomNavigationBarItem(
//       icon: Icon(Icons.home),
//       label: 'Home',
//     ),
//     const BottomNavigationBarItem(
//       icon: Icon(FontAwesomeIcons.map),
//       label: 'Map',
//     ),
//     // const BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
//   ];

//   var widget = [
//     const PropertiesView(),
//     GoogleMapView(
//       select: false,
//       locations: [
//         RegionModel(id: 1, name: 'manar', x: 12.4543, y: 12.054656),
//         RegionModel(id: 2, name: 'manar', x: 11.4543, y: 11.054656),
//         RegionModel(id: 3, name: 'manar', x: 10.4543, y: 10.054656),
//         RegionModel(id: 4, name: 'manar', x: 9.4543, y: 9.054656),
//         RegionModel(id: 5, name: 'manar', x: 8.4543, y: 8.054656),
//       ],
//     ),
//   ];
//   void changeIndex(int index) {
//     emit(HomeInitial());
//     this.index = index;
//     emit(ChangeIndex());
//   }

//   Future<void> getNearestProps() async {
//     (await ShowAllPropertiesService.showAll(
//       token: await CacheHelper.getData(key: 'Token'),
//     ))
//         .fold(
//       (failure) {
//         emit(HomeMapFailure());
//       },
//       (props) {
//         emit(HomeMapSuccess(props));
//       },
//     );
//   }

//   Future<void> getMyLocation() async {
//     await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     ).then(
//       (position) {
//         myX = position.latitude;
//         myY = position.longitude;
//       },
//     );
//   }

//   // double? getDistance({required double lat, required double lon}) {
//   //   if (myX != null && myY != null) {
//   //     var p = 0.017453292519943295;
//   //     var c = cos;
//   //     var a = 0.5 -
//   //         c((lat - myX!) * p) / 2 +
//   //         c(myX! * p) * c(lat * p) * (1 - c((lon - myY!) * p)) / 2;
//   //     return 12742 * asin(sqrt(a));
//   //   }
//   //   return null;
//   // }

//   double? getDistance2({required double lat, required double lon}) {
//     if (myX != null && myY != null) {
//       return (Geolocator.distanceBetween(myX!, myY!, lat, lon) / 1000);
//     }
//     return null;
//   }
// }
