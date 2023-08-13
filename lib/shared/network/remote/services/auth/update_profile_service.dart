import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import '../../../../errors/failure.dart';
import '../../dio_helper.dart';

abstract class UpdateProfileService {
  static Future<Either<Failure, void>> updateProfile({
    required String newName,
    required String email,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'auth/updateUser',
        data: {
          'name': newName,
          'email': email,
        },
        token: await CacheHelper.getData(key: 'Token'),
      );
      log(response.toString());

      return right(null);
    } catch (ex) {
      log('\nException: there is an error in updateProfile method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
