import 'package:equatable/equatable.dart';
import 'package:untitled/shared/models/user_model.dart';

abstract class RegisterStates extends Equatable {
  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterStates {}

final class RegisterLoading extends RegisterStates {}

final class RegisterFailure extends RegisterStates {
  final String failureMsg;

  RegisterFailure({required this.failureMsg});
}

final class RegisterSuccess extends RegisterStates {
  final UserModel userModel;

  RegisterSuccess({required this.userModel});
}

// final class ChangePasswordState extends RegisterStates {}
