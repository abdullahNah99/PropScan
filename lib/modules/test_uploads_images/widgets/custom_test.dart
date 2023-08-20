// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:untitled/modules/properties_screen/widgets/row_details.dart';

// import 'package:untitled/shared/models/property_model.dart';

// import 'package:untitled/shared/network/remote/services/properties/show_all_preoperties_service.dart';
// import '../cubit/test_cubit.dart';
// import '../test2.dart';

// class PropertyCard2 extends StatelessWidget {
//   final int index;
//   // final TestSuccess testSuccess;
//   final List<PropertyModel> props;
//   final TestCubit testCubit;
//   final double distance;

//   const PropertyCard2({
//     super.key,
//     required this.index,
//     required this.props,
//     // required this.testSuccess,
//     required this.testCubit,
//     required this.distance,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Test2(
//                 testCubit: testCubit,
//                 propertyModel: props[index],
//                 // propertyModel: testSuccess.getNearetsProps(
//                 //     myX: testCubit.myX!, myY: testCubit.myY!)[index],
//               ),
//             ));
//         // Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //       builder: (context) => GoogleMapView(
//         //         select: false,
//         //         locations: const [],
//         //         lat: testCubit.myX,
//         //         lon: testCubit.myY,
//         //       ),
//         //     ));
//       },
//       child: Card(
//         key: key,
//         elevation: 8,
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10.r),
//                       topRight: Radius.circular(10.r),
//                     ),
//                     image: const DecorationImage(
//                       image: AssetImage('assets/images/a2.jpg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: 10.w,
//                   top: 5.h,
//                   child: TextButton(
//                     onPressed: () {
//                       log('mmmm');
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(2),
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50.r),
//                         color: Colors.grey[50],
//                       ),
//                       child: const Center(
//                         child: Icon(
//                           Icons.favorite_border,
//                           color: Colors.red,
//                           size: 30,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             const RowDetails(
//               icon: Icons.phone,
//               text: '0934487928',
//             ),
//             const RowDetails(
//               icon: Icons.location_on_outlined,
//               text: 'xxxxxxxxxxxx',
//             ),
//             RowDetails(
//               icon: Icons.social_distance,
//               text: '$distance',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
