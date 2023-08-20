import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../../shared/models/property_model.dart';

abstract class TestState extends Equatable {
  const TestState();

  @override
  List<Object> get props => [];
}

final class TestInitial extends TestState {}

final class TestLoading extends TestState {}

final class TestSuccess extends TestState {
  @override
  final List<PropertyModel> props;

  const TestSuccess(this.props);

  double getDistance({
    required double myX,
    required double myY,
    required double lat,
    required double lon,
  }) {
    return (Geolocator.distanceBetween(myX, myY, lat, lon) / 1000);
  }

  List<PropertyModel> getNearetsProps(
      {required double myX, required double myY}) {
    List<PropertyModel> nearest = [];
    for (PropertyModel item in props) {
      if (getDistance(myX: myX, myY: myY, lat: item.x, lon: item.y) < 11) {
        nearest.add(item);
      }
    }
    return nearest;
  }
}

final class TestFailure extends TestState {}
