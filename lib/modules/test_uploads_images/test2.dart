import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/test_uploads_images/cubit/test_cubit.dart';
import '../../shared/models/property_model.dart';

class Test2 extends StatelessWidget {
  final PropertyModel propertyModel;
  final TestCubit testCubit;
  const Test2({
    super.key,
    required this.propertyModel,
    required this.testCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 400.w),
          Text(propertyModel.governorate),
          const SizedBox(height: 10),
          Text(propertyModel.region),
          const SizedBox(height: 10),
          Text(propertyModel.state),
          const SizedBox(height: 10),
          Text(propertyModel.type),
          const SizedBox(height: 10),
          Text(propertyModel.price.toString()),
          const SizedBox(height: 10),
          Text(propertyModel.space.toString()),
          const SizedBox(height: 10),
          Text(propertyModel.x.toString()),
          const SizedBox(height: 10),
          Text(propertyModel.y.toString()),
          const SizedBox(height: 50),
          Text(
            'Distance2 = ${testCubit.getDistance2(lat: propertyModel.x, lon: propertyModel.y)}',
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
