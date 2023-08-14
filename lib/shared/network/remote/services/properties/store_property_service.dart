import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:untitled/shared/models/store_property_model.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import '../../../../errors/failure.dart';
import '../../dio_helper.dart';

abstract class StorePropertyService {
  static Future<Either<Failure, void>> storeProperty({
    required StorePropertyModel storePropertyModel,
    required List<String> images,
  }) async {
    try {
      if (storePropertyModel is StoreHouseModel) {
        await DioHelper.postWithImage(
          endPoint: 'properties/',
          body: {
            'price': storePropertyModel.price.toString(),
            'space': storePropertyModel.space.toString(),
            'region_id': storePropertyModel.regionID.toString(),
            'x': storePropertyModel.x.toString(),
            'y': storePropertyModel.y.toString(),
            'property_type_id': 1.toString(),
            'number_of_rooms': storePropertyModel.numOfRooms.toString(),
            'number_of_bathroom': storePropertyModel.numOfBathrooms.toString(),
            'number_of_balcony': storePropertyModel.numOfBalcony.toString(),
            'description': storePropertyModel.description,
            'direction': storePropertyModel.direction,
          },
          imagesPaths: images,
          token:
              'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC40My4zNzo4MDAwL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNjkyMDExNDEyLCJleHAiOjE2OTIwMTUwMTIsIm5iZiI6MTY5MjAxMTQxMiwianRpIjoiMndmUGNKYUhuNzhOS2FMQyIsInN1YiI6IjUiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.WVifg_WPfPvOPOdHtvX3LgpG_Nxr9Gy4fxkPRVNF1ic',
        );
      } else if (storePropertyModel is StoreFarmModel) {
        await DioHelper.postWithImage(
          endPoint: 'properties/',
          body: {
            'price': storePropertyModel.price.toString(),
            'space': storePropertyModel.space.toString(),
            'region_id': storePropertyModel.regionID.toString(),
            'x': storePropertyModel.x.toString(),
            'y': storePropertyModel.y.toString(),
            'property_type_id': 2.toString(),
            'number_of_rooms': storePropertyModel.numOfRooms.toString(),
            'number_of_pools': storePropertyModel.numOfPools.toString(),
            'is_baby_pool': storePropertyModel.isBabyPool.toString(),
            'is_bar': storePropertyModel.isBar.toString(),
            'is_garden': storePropertyModel.isGarden.toString(),
            'description': storePropertyModel.description,
          },
          imagesPaths: images,
          token: CacheHelper.getData(key: 'Token'),
        );
      } else if (storePropertyModel is StoreMarketModel) {
        await DioHelper.postWithImage(
          endPoint: 'properties/',
          body: {
            'price': storePropertyModel.price.toString(),
            'space': storePropertyModel.space.toString(),
            'region_id': storePropertyModel.regionID.toString(),
            'x': storePropertyModel.x.toString(),
            'y': storePropertyModel.y.toString(),
            'property_type_id': 3.toString(),
            'description': storePropertyModel.description,
          },
          imagesPaths: images,
          token: CacheHelper.getData(key: 'Token'),
        );
      }

      return right(null);
    } catch (ex) {
      log('\nException: there is an error in storeProperty method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
