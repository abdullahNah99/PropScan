import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/add_property_screen/cubit/add_property_cubit.dart';
import 'package:untitled/modules/add_property_screen/widgets/property_text_field.dart';
import '../../../shared/styles/app_colors.dart';

class PageViewItem extends StatelessWidget {
  final AddPropertyCubit cubit;
  const PageViewItem({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey),
      ),
      child: Form(
        key: cubit.formKey,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            if (cubit.selectedTypeIndex == 0)
              Column(
                children: [
                  PropertyInfoItem(
                    text: 'Number of bathrooms',
                    onChanged: (p0) => cubit.numOfBathrooms = int.parse(p0),
                  ),
                  Divider(color: Colors.grey, height: 20.h),
                  PropertyInfoItem(
                    text: 'Number of balcony',
                    onChanged: (p0) => cubit.numOfBalcony = int.parse(p0),
                  ),
                  Divider(color: Colors.grey, height: 20.h),
                  PropertyInfoItem(
                    text: 'Number of rooms',
                    onChanged: (p0) => cubit.numOfRooms = int.parse(p0),
                  ),
                  Divider(color: Colors.grey, height: 20.h),
                ],
              ),
            if (cubit.selectedTypeIndex == 1)
              Column(
                children: [
                  PropertyInfoItem(
                    text: 'Number of rooms',
                    onChanged: (p0) => cubit.numOfRooms = int.parse(p0),
                  ),
                  Divider(color: Colors.grey, height: 20.h),
                  PropertyInfoItem(
                    text: 'Number of pools',
                    onChanged: (p0) => cubit.numOfPools = int.parse(p0),
                  ),
                  Divider(color: Colors.grey, height: 20.h),
                ],
              ),
            PropertyInfoItem(
              text: 'Space',
              onChanged: (p0) => cubit.space = int.parse(p0),
            ),
            Divider(color: Colors.grey, height: 20.h),
            PropertyInfoItem(
              text: 'Price',
              onChanged: (p0) => cubit.price = int.parse(p0),
            ),
            Divider(color: Colors.grey, height: 20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                    color: AppColors.color2,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Center(
                  child: PropertyTextField(
                    width: 250.w,
                    maxLines: 3,
                    // hintText: 'Description',
                    keyboardType: TextInputType.multiline,
                    onChanged: (p0) => cubit.description = p0,
                  ),
                ),
                if (cubit.selectedTypeIndex == 1)
                  Column(
                    children: [
                      Divider(color: Colors.grey, height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          cubit.farm.keys.length,
                          (index) {
                            return Container(
                              height: 45.h,
                              width: 100.w,
                              margin: EdgeInsets.only(top: 30.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: cubit.farm.values.elementAt(index)
                                    ? AppColors.defaultColor
                                    : AppColors.color2.withOpacity(.4),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  cubit.selectFarmDetails(index);
                                },
                                child: Text(
                                  cubit.farm.keys.elementAt(index),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                if (cubit.selectedTypeIndex == 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: Colors.grey, height: 20.h),
                      Text(
                        'Direction',
                        style: TextStyle(
                          color: AppColors.color2,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          cubit.directions.keys.length,
                          (index) {
                            return Container(
                              height: 45.h,
                              width: 70.w,
                              margin: EdgeInsets.only(top: 30.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: cubit.directions.values.elementAt(index)
                                    ? AppColors.defaultColor
                                    : AppColors.color2.withOpacity(.4),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  cubit.selectDirections(index);
                                },
                                child: Text(
                                  cubit.directions.keys.elementAt(index),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
