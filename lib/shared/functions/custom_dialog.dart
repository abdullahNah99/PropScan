import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:untitled/main.dart';

import 'package:untitled/modules/property_details_screen/cubit/property_details_cubit.dart';

import 'package:untitled/modules/property_details_screen/property_details_screen.dart';
import 'package:untitled/shared/widgets/custome_button.dart';
import '../models/property_model.dart';

abstract class CustomDialog {
  static void detailsDialog(BuildContext context,
      {required PropertyModel element}) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 200.h,
                child: PhotoViewGallery.builder(
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.white),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 4,
                      imageProvider: NetworkImage(
                        "http://192.168.43.37:8000/${element.images[index]["image"]}",
                      ),
                      initialScale: PhotoViewComputedScale.contained,
                    );
                  },
                  itemCount: element.images.length,
                  loadingBuilder: (context, event) => Center(
                    child: SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded /
                                event.expectedTotalBytes!.toInt(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Price : ${element.price}.SP",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Space : ${element.space} ",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "type : ${element.type} ",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "governorate : ${element.governorate} ",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "region : ${element.region} ",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 30.h,
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, PropertyDetailsView.route,
                        arguments: {
                          "propertyID": element.id,
                        });
                  },
                  child: const Text('More information'),
                ),
              ),
            ],
          ),
        );
        // actions: [

        // ],
      },
    );
  }

  static void showCustomDialog(
    BuildContext context, {
    required List<Widget> children,
    double? hight,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            height: hight ?? 300.h,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  static void showDailyRentDialog(
    BuildContext context, {
    required Widget dailyRentGrid,
    required PropertyDetailsCubit propertyDetailsCubit,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            CustomeButton(
              text: 'Confirm',
              onPressed: () {
                log(propertyDetailsCubit.getSelectedDates().toString());

                // showCustomDialog(context,
                //     children: List.generate(3, (index) => const Text('Test')));
              },
            ),
          ],
          content: Container(
            width: screenSize.width,
            height: screenSize.height * .7,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: dailyRentGrid,
          ),
        );
      },
    ).whenComplete(() {
      propertyDetailsCubit.dailyRentStartIndex = null;
      propertyDetailsCubit.dailyRentEndIndex = null;
    });
  }
}
