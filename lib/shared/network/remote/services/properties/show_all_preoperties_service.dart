import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failure.dart';
import '../../dio_helper.dart';

abstract class ShowAllPropertiesService {
  static Future<Either<Failure, List<PropertyModel>>> showAll(
      {required String token}) async {
    try {
      var response = await DioHelper.getData(
        url: 'properties/show/all',
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
      return left(ServerFailure(ex.toString()));
    }
  }
}

class PropertyModel {
  final int id;
  final int price;
  final int space;
  final String state;
  final String governorate;
  final String region;
  final String type;
  final double x;
  final double y;
  final List<String> images;

  PropertyModel({
    required this.id,
    required this.price,
    required this.space,
    required this.state,
    required this.governorate,
    required this.region,
    required this.type,
    required this.x,
    required this.y,
    required this.images,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> jsonData) {
    return PropertyModel(
      id: jsonData['id'],
      price: jsonData['price'],
      space: jsonData['space'],
      state: jsonData['state'],
      governorate: jsonData['governorate'],
      region: jsonData['region'],
      type: jsonData['type'],
      x: jsonData['x'],
      y: jsonData['y'],
      images: jsonData['images'],
    );
  }
}
