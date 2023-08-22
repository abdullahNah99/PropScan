import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failure.dart';
import '../../dio_helper.dart';

abstract class GetReservationDatesService {
  static Future<Either<Failure, List<ReservationModel>>> getReservationDates(
      {required int propertyID}) async {
    try {
      List<ReservationModel> reservationDates = [];
      var response = await DioHelper.getData(
        url: 'date/$propertyID',
      );
      for (var item in response.data['properties']) {
        reservationDates.add(ReservationModel.fromJson(item));
      }
      log(response.toString());
      return right(reservationDates);
    } catch (ex) {
      log('\nException: there is an error in getReservationDates method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}

class ReservationModel {
  final String startDate;
  final String endDate;

  ReservationModel({required this.startDate, required this.endDate});

  factory ReservationModel.fromJson(Map<String, dynamic> jsonData) {
    return ReservationModel(
      startDate: jsonData['start_date'],
      endDate: jsonData['end_date'],
    );
  }
}
