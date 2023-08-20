// part of 'home_cubit.dart';

// sealed class HomeState extends Equatable {
//   const HomeState();

//   @override
//   List<Object> get props => [];
// }

// final class HomeInitial extends HomeState {}

// final class ChangeIndex extends HomeState {}

// final class HomeMapLoading extends HomeState {}

// final class HomeMapSuccess extends HomeState {
//   @override
//   final List<PropertyModel> props;

//   const HomeMapSuccess(this.props);

//   double getDistance({
//     required double myX,
//     required double myY,
//     required double lat,
//     required double lon,
//   }) {
//     return (Geolocator.distanceBetween(myX, myY, lat, lon) / 1000);
//   }

//   List<PropertyModel> getNearetsProps(
//       {required double myX, required double myY}) {
//     List<PropertyModel> nearest = [];
//     for (PropertyModel item in props) {
//       if (getDistance(myX: myX, myY: myY, lat: item.x, lon: item.y) < 11) {
//         nearest.add(item);
//       }
//     }
//     return nearest;
//   }
// }

// final class HomeMapFailure extends HomeState {}
