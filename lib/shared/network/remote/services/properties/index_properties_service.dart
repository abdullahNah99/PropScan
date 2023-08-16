import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failure.dart';
import '../../../../models/region_model.dart';
import '../../dio_helper.dart';

abstract class GetGovernoratesRegionsService {
  static Future<Either<Failure, List<RegionModel>>> getGovernoratesRegions(
      {required int governorateID}) async {
    try {
      var response = await DioHelper.getData(
        url: 'governorates/$governorateID/regions',
      );
      log(response.toString());
      List<RegionModel> regions = [];
      for (var item in response.data['regions']) {
        regions.add(RegionModel.fromJson(item));
      }
      return right(regions);
    } catch (ex) {
      log('\nException: there is an error in getGovernoratesRegions method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
