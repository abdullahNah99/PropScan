import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/shared/styles/app_colors.dart';
import 'package:untitled/shared/utils/app_assets.dart';
import 'package:untitled/shared/widgets/custome_image.dart';

class LoginDesignSection extends StatelessWidget {
  const LoginDesignSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 500.w,
          height: 80.w,
        ),
        const CustomeImage(
          image: AppAssets.logo,
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(height: 10),
        Text(
          'Welcome To PropScan',
          style: TextStyle(
            color: AppColors.defaultColor,
            fontSize: 27.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'helping you to find the best choice',
          style: TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
