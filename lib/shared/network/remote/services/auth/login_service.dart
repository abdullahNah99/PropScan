import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failure.dart';
import '../../../../models/user_model.dart';
import '../../dio_helper.dart';

abstract class LoginService {
  static Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'auth/login',
        data: {
          "email": email,
          "password": password,
        },
      );
      log(response.toString());

      return right(UserModel.fromJson(response.data));
    } catch (ex) {
      log('\nException: there is an error in login method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
