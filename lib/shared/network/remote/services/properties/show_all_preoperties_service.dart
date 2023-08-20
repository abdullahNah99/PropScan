import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failure.dart';
import '../../../../models/property_model.dart';
import '../../dio_helper.dart';

abstract class ShowAllPropertiesService {
  static Future<Either<Failure, List<PropertyModel>>> showAll(
      {required String token}) async {
    try {
      var response = await DioHelper.getData(
        url: 'properties/show/all',
        token: token,
      );
      log(response.toString());
      List<PropertyModel> properties = [];
      for (var item in response.data['properties']) {
        properties.add(PropertyModel.fromJson(item));
      }
      return right(properties);
    } catch (ex) {
      log('\nException: there is an error in showAll method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      log(ex.toString());
      return left(ServerFailure(ex.toString()));
    }
  }
}
