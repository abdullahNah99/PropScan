// import 'dart:developer';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:untitled/shared/network/remote/services/properties/show_all_preoperties_service.dart';
// import '../../../../errors/failure.dart';
// import '../../../../models/region_model.dart';
// import '../../dio_helper.dart';

// abstract class IndexPropertiesService {
//   static Future<Either<Failure, List<RegionModel>>> indexProperties(
//       {required String token}) async {
//     try {
//       var response = await DioHelper.getData(
//         url: 'properties/?page=&per_page=',
//       );
//       log(response.toString());
//       List<PropertyModel> properties = [];
//       for (var item in response.data['regions']) {
//         properties.add(PropertyModel.fromJson(item));
//       }
//       return right(regions);
//     } catch (ex) {
//       log('\nException: there is an error in getGovernoratesRegions method');
//       log('\n${ex.toString()}');
//       if (ex is DioException) {
//         return left(ServerFailure.fromDioError(ex));
//       }
//       return left(ServerFailure(ex.toString()));
//     }
//   }
// }
