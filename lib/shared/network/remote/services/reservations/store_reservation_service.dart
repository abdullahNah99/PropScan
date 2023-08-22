import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failure.dart';
import '../../dio_helper.dart';

abstract class StoreReservationService {
  static Future<Either<Failure, void>> storeReservation({
    required String token,
    required String startDate,
    required String endDate,
    required int price,
    required int propertyID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'reservations',
        data: {
          'property_id': propertyID,
          'start_date': startDate,
          'end_date': endDate,
          'price': price,
          'reservation_type_id': 3,
        },
      );
      log(response.toString());

      return right(null);
    } catch (ex) {
      log('\nException: there is an error in storeReservation method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
