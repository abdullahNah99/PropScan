import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled/shared/constant/const.dart';
import '../../../../errors/failure.dart';
import '../../dio_helper.dart';

abstract class WithDrawService {
  static Future<Either<Failure, void>> withdraw({
    required String email,
    required double value,
  }) async {
    try {
      var response = await DioHelper.putData(
        url: 'admin/financial/withdraw',
        data: {
          "email": email,
          "value": value,
        },
        token: adminToken,
      );
      log(response.toString());

      return right(null);
    } catch (ex) {
      log('\nException: there is an error in withdraw method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
