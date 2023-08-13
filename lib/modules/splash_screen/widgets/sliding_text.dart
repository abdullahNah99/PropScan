import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/shared/styles/app_colors.dart';
import 'package:untitled/shared/utils/app_assets.dart';
import 'package:untitled/shared/widgets/custome_image.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      //  AnimatedBuilder لتحسين الأداء استخدمنا
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: Column(
            children: [
              SizedBox(width: 500.w),
              const CustomeImage(
                image: AppAssets.logo,
              ),
              const Text(
                'Welcome To PropScan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.defaultColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
