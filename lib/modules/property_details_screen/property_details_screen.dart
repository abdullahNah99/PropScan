import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/shared/styles/app_colors.dart';

class PropertyDetailsView extends StatelessWidget {
  static const route = 'PropertyDetailsView';
  const PropertyDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 200.h,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.linear,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              enlargeFactor: 0.3,
            ),
            items: [
              'assets/images/a1.jpg',
              'assets/images/a2.jpg',
              'assets/images/a3.jpg',
              'assets/images/a4.jpg',
              'assets/images/a5.jpg',
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                        image: AssetImage(i),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Divider(
            endIndent: 30.w,
            indent: 30.w,
            thickness: 2,
            color: AppColors.defaultColor,
          )
        ],
      ),
    );
  }
}
