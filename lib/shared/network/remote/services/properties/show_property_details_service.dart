import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled/shared/models/property_details_model.dart';
import '../../../../errors/failure.dart';
import '../../dio_helper.dart';

abstract class ShowPropertyDetailsService {
  static Future<Either<Failure, PropertyDetailsModel>> showDetails(
      {required String token, required int propertyID}) async {
    try {
      var response = await DioHelper.getData(
        url: 'properties/$propertyID',
        token: token,
      );
      log(response.toString());

      return right(PropertyDetailsModel.fromJson(response.data['property']));
    } catch (ex) {
      log('\nException: there is an error in showDetails method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        log(ex.response.toString());
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
