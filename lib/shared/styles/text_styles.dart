import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

abstract class Styles {
  static TextStyle textStyle16 = TextStyle(
    color: AppColors.defaultColor,
    fontSize: 16.sp,
    letterSpacing: .6,
  );

  static TextStyle textStyle18 = TextStyle(
    color: Colors.grey,
    fontSize: 18.sp,
    letterSpacing: .8,
  );

  static TextStyle textStyle20 = TextStyle(
    color: AppColors.defaultColor,
    fontSize: 20.sp,
  );

  static TextStyle textStyle25 = TextStyle(
    color: AppColors.defaultColor,
    fontSize: 25.sp,
  );

  static TextStyle textStyle30 = TextStyle(
    color: AppColors.defaultColor,
    fontSize: 30.sp,
  );

  static TextStyle textStyle50 = TextStyle(
    color: AppColors.defaultColor,
    fontSize: 50.sp,
  );
}
