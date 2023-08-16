import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/styles/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 150.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            image: const DecorationImage(
              image: AssetImage('assets/images/a8.png'),
              // fit: BoxFit.cover,
            ),
          ),
        ),
        const Spacer(),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.maps_home_work_outlined,
            size: 120,
            color: AppColors.defaultColor,
          ),
        ),
      ],
    );
  }
}
