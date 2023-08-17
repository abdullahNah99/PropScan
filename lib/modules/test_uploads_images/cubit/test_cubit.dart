import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:untitled/modules/test_uploads_images/cubit/test_state.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/network/remote/services/properties/show_all_preoperties_service.dart';

class TestCubit extends Cubit<TestState> {
  double? myX;
  double? myY;

  TestCubit() : super(TestInitial());

  Future<void> getNearestProps() async {
    (await ShowAllPropertiesService.showAll(
      token: await CacheHelper.getData(key: 'Token'),
    ))
        .fold(
      (failure) {
        emit(TestFailure());
      },
      (props) {
        emit(TestSuccess(props));
      },
    );
  }

  Future<void> getMyLocation() async {
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
