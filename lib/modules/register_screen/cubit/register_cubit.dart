import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:untitled/modules/register_screen/cubit/register_states.dart';
import 'package:untitled/shared/network/remote/firebase/firebase_apis.dart';
import '../../../shared/network/remote/services/auth/register_service.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  String? name, email, password, confirmPassword;
  final formKey = GlobalKey<FormState>();
  // bool obscureText = true;
  // IconData icon = Icons.remove_red_eye;

  RegisterCubit() : super(RegisterInitial());

  Future<void> register() async {
    emit(RegisterLoading());
    await FirebaseAPIs.createUserWithEmailAndPassword(
            email: email!, password: password!)
        .then(
      (value) async {
        if (value != null) {
          (await RegisterService.register(
                  name: name!,
                  email: email!,
                  password: password!,
                  confirmPass: confirmPassword!))
              .fold(
            (failure) {
              emit(RegisterFailure(failureMsg: failure.errorMessege));
            },
            (userModel) {
              emit(RegisterSuccess(userModel: userModel));
            },
          );
        } else {
          emit(RegisterFailure(
              failureMsg: 'Something Went Wrong, Please Try Again'));
        }
      },
    ).catchError(
      // ignore: argument_type_not_assignable_to_error_handler
      () {
        emit(RegisterFailure(
            failureMsg: 'Something Went Wrong, Please Try Again'));
      },
    );
  }

  // void changePasswordState() {
  //   obscureText = !obscureText;
  //   if (!obscureText) {
  //     icon = FontAwesomeIcons.solidEyeSlash;
  //     emit(RegisterInitial());
  //   } else {
  //     icon = FontAwesomeIcons.solidEye;
  //     emit(ChangePasswordState());
  //   }
  // }
}
