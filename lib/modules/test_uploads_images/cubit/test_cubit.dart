import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/modules/test_uploads_images/cubit/test_state.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/services/properties/index_properties_service.dart';

import '../../../shared/models/property_model.dart';

class TestCubit extends Cubit<TestState> {
  double? myX;
  double? myY;

  List<PropertyModel> testList = [];

  TestCubit() : super(TestInitial());

  // Future<void> getNearestProps() async {
  //   (await ShowAllPropertiesService.showAll(
  //     token: await CacheHelper.getData(key: 'Token'),
  //   ))
  //       .fold(
  //     (failure) {
  //       emit(TestFailure());
  //     },
  //     (props) {
  //       emit(TestSuccess(props));
  //     },
  //   );
  // }
  Future<void> getNearestProps() async {
    getMyLocation().then(
      (value) async {
        (await IndexPropertiesService.indexProperties(
          token: await CacheHelper.getData(key: 'Token'),
          x: value.latitude,
          y: value.longitude,
        ))
            .fold(
          (failure) {
            emit(TestFailure());
          },
          (props) {
            for (var item in props) {
              if (getDistance2(lat: item.x, lon: item.y)! < 15) {
                testList.add(item);
              } else {
                break;
              }
            }
            emit(TestSuccess(props));
          },
        );
      },
    );
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

  Future<void> getMyLocation2() async {
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then(
      (position) {
        myX = position.latitude;
        myY = position.longitude;
      },
    );
  }

  // double? getDistance({required double lat, required double lon}) {
  //   if (myX != null && myY != null) {
  //     var p = 0.017453292519943295;
  //     var c = cos;
  //     var a = 0.5 -
  //         c((lat - myX!) * p) / 2 +
  //         c(myX! * p) * c(lat * p) * (1 - c((lon - myY!) * p)) / 2;
  //     return 12742 * asin(sqrt(a));
  //   }
  //   return null;
  // }

  double? getDistance2({required double lat, required double lon}) {
    if (myX != null && myY != null) {
      return (Geolocator.distanceBetween(myX!, myY!, lat, lon) / 1000);
    }
    return null;
  }
}
