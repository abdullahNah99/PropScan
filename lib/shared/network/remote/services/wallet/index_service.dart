import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../errors/failure.dart';
import '../../dio_helper.dart';

abstract class WalletIndexService {
  static Future<Either<Failure, List<WalletDataModel>>> walletIndex(
      {required int propertyID}) async {
    try {
      List<WalletDataModel> walletData = [];
      var response = await DioHelper.getData(
        url: 'wallet/?per_page=&page=',
      );
      var data = response.data['wallet']['walletOperations']['data'];
      for (var item in data) {
        walletData.add(WalletDataModel.fromJson(item));
      }
      log(response.toString());
      return right(walletData);
    } catch (ex) {
      log('\nException: there is an error in walletIndex method');
      log('\n${ex.toString()}');
      if (ex is DioException) {
        return left(ServerFailure.fromDioError(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}

class WalletDataModel {
  final int id;
  final double value;
  final bool type;
  final String description;
  final int walletID;

  WalletDataModel({
    required this.id,
    required this.value,
    required this.type,
    required this.description,
    required this.walletID,
  });

  factory WalletDataModel.fromJson(Map<String, dynamic> jsonData) {
    return WalletDataModel(
      id: jsonData['id'],
      value: jsonData['value'],
      type: jsonData['type'],
      description: jsonData['description'],
      walletID: jsonData['wallet_id'],
    );
  }
}
