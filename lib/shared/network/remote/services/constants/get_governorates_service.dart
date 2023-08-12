import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failure.dart';
import '../../../../models/governorate_model.dart';
import '../../dio_helper.dart';

abstract class GetGovernoratesService {
  static Future<Either<Failure, List<GovernorateModel>>>
      getGovernorates() async {
    try {
      var response = await DioHelper.getData(
        url: 'governorates',
      );
      log(response.toString());
      List<GovernorateModel> governorates = [];
      for (var item in response.data['governorates']) {
        governorates.add(GovernorateModel.fromJson(item));
      }
      return right(governorates);
    } catch (ex) {
      log('\nException: there is an error in getGovernorates method');
      log('\n$ex');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
