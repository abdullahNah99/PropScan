import 'package:equatable/equatable.dart';

abstract class PropertiesStates extends Equatable {
  @override
  List<Object> get props => [];
}

final class PropertiesInitial extends PropertiesStates {}

final class PropertiesLoading extends PropertiesStates {}

final class PropertiesFailure extends PropertiesStates {}

final class PropertiesSuccess extends PropertiesStates {}
