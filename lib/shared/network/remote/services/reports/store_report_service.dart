import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failure.dart';
import '../../../../models/message_model.dart';
import '../../dio_helper.dart';

abstract class StoreReportService {
  static Future<Either<Failure, MessageModel>> addReport({
    required String token,
    required int propertyID,
    required String description,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'reports',
        data: {
          'property_id': propertyID,
          'description': description,
        },
        token: token,
      );
      log(response.toString());

      return right(MessageModel.fromJson(response.data));
    } catch (ex) {
      log('\nException: there is an error in addReport method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
