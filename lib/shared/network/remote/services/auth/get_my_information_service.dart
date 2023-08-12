import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failure.dart';
import '../../../../models/user_model.dart';
import '../../dio_helper.dart';

abstract class GetMyInformationService {
  static Future<Either<Failure, UserModel>> getMyInfo(
      {required String token}) async {
    try {
      var response = await DioHelper.getData(
        url: 'auth/me',
        token: token,
      );
      log(response.toString());
      return right(UserModel.fromJson(response.data));
    } catch (ex) {
      log('\nException: there is an error in getMyInfo method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
