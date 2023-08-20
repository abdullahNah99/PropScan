import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled/shared/network/remote/services/properties/show_all_preoperties_service.dart';
import '../../../../errors/failure.dart';
import '../../dio_helper.dart';

abstract class IndexPropertiesService {
  static Future<Either<Failure, List<PropertyModel>>> indexProperties(
      {required String token, required double x, required double y}) async {
    try {
      var response = await DioHelper.getData(
        url: 'properties/?page=&per_page=',
        token: token,
        query: {
          'x': x,
          'y': y,
        },
      );
      log(response.toString());
      List<PropertyModel> properties = [];
      for (var item in response.data['properties']['data']) {
        properties.add(PropertyModel.fromJson(item));
      }
      return right(properties);
    } catch (ex) {
      log('\nException: there is an error in indexProperties method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        log(ex.response.toString());
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
