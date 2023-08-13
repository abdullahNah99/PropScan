import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/add_property_screen/cubit/add_property_cubit.dart';

class SelectedImagesList extends StatelessWidget {
  final AddPropertyCubit cubit;
  const SelectedImagesList({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: cubit.selectedImagesList.isNotEmpty
          ? ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: cubit.selectedImagesList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: FileImage(
                        File(cubit.selectedImagesList[index].path),
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'Please Select Images',
                style: TextStyle(color: Colors.grey, fontSize: 30.sp),
              ),
            ),
    );
  }
}
