import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failure.dart';
import '../../../../models/user_model.dart';
import '../../dio_helper.dart';

abstract class RegisterService {
  static Future<Either<Failure, UserModel>> register({
    required String name,
    required String email,
    required String password,
    required String confirmPass,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'auth/register',
        data: {
          "name": name,
          "email": email,
          "password": password,
          "c_password": confirmPass,
        },
      );
      log(response.toString());

      return right(UserModel.fromJson(response.data));
    } catch (ex) {
      log('\nException: there is an error in register method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }

      return left(ServerFailure(ex.toString()));
    }
  }
}
