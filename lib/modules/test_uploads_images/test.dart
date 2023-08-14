// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:untitled/shared/models/store_property_model.dart';
// import 'package:untitled/shared/network/local/cache_helper.dart';
// import '../../shared/network/remote/services/properties/store_property_service.dart';

// class TestUploadImages extends StatelessWidget {
//   const TestUploadImages({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           onPressed: () async {
//             final ImagePicker picker = ImagePicker();

//             //picking multiple images
//             final List<XFile> images =
//                 await picker.pickMultiImage(imageQuality: 70);

//             List<String> pImsg = [];
//             for (var i in images) {
//               log('Image Path: ${i.path}');
//               pImsg.add(i.path);

//               // setState(() => _isUploading = true);
//               // await APIs.sendChatImage(widget.user, File(i.path));
//               // setState(() => _isUploading = false);
//             }
//             await CacheHelper.saveData(
//                 key: 'Token',
//                 value:
//                     'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC40My4zNzo4MDAwL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNjkxOTI4NTQ3LCJleHAiOjE2OTE5MzIxNDcsIm5iZiI6MTY5MTkyODU0NywianRpIjoiTWtxaHlxSTEwZlR2aEQ3TyIsInN1YiI6IjUiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.ZxOJYPCSdO32R3k6Qgp-SeXafe3_QjnHjfCmXghFqq0');
//             StorePropertyModel s = StoreFarmModel(
//               numOfRooms: 5,
//               description: 'Testooo',
//               price: 1000000,
//               space: 100,
//               regionID: 1,
//               propertyTypeID: 2,
//               x: 100.12,
//               y: 110.11,
//               isBabyPool: true,
//               isBar: false,
//               isGarden: true,
//               numOfPools: 2,
//             );
//             await StorePropertyService.storeProperty(
//               storePropertyModel: s,
//               images: pImsg,
//             );
//           },
//           child: const Text('Upload'),
//         ),
//       ),
//     );
//   }
// }

// // final multipartImageList = images
// //                 .map((image) async => MultipartFile.fromFileSync(image.path,
// //                     filename: image.path.split('/').last))
// //                 .toList();

// //             var formData = FormData.fromMap({
// //               'price': 1000000,
// //               'space': 99,
// //               'region_id': 1,
// //               'images': multipartImageList
// //             });

// // try {
// //               await Dio().post('http://192.168.43.37:8000/api/properties/',
// //                   data: formData,
// //                   options: Options(
// //                       receiveDataWhenStatusError: true,
// //                       method: 'POST',
// //                       headers: {
// //                         'auth-token': await CacheHelper.getData(key: 'Token')
// //                       }));
// //             } catch (e) {
// //               log(e.toString());
// //             }

import 'package:flutter/material.dart';
import 'package:untitled/shared/widgets/custome_image.dart';

class Testoo extends StatelessWidget {
  const Testoo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomeFileImage(filePath: ''),
      ),
    );
  }
}
