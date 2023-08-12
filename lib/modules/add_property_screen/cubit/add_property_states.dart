import 'package:equatable/equatable.dart';

abstract class AddPropertyStates extends Equatable {
  @override
  List<Object> get props => [];
}

class AddPropertyInitial extends AddPropertyStates {}

class AddPropertyLoading extends AddPropertyStates {}

class AddPropertyFailure extends AddPropertyStates {
  final String failureMsg;

  AddPropertyFailure({required this.failureMsg});
}

class AddPropertySuccess extends AddPropertyStates {}

class SelectItemState extends AddPropertyStates {}

class FetchItemsLoading extends AddPropertyStates {}
