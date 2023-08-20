import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:untitled/main.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_cubit.dart';
import 'package:untitled/shared/widgets/custome_button.dart';

import '../models/property_model.dart';

abstract class CustomDialog {
  static void detailsDialog(BuildContext context,
      {required PropertyModel element}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250.h,
                child: PhotoViewGallery.builder(
                  backgroundDecoration:
                      BoxDecoration(color: Colors.black.withOpacity(.85)),
                  // pageController:
                  //     PageController(initialPage: indexS),
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
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('More information'),
            ),
          ],
        );
      },
    );
  }

  static void showCustomDialog(
    BuildContext context, {
    required List<Widget> children,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SizedBox(
            height: 300.h,
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
    required PropertiesCubit propertiesCubit,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            CustomeButton(
              text: 'Confirm',
              onPressed: () {
                log(propertiesCubit.getSelectedDates().toString());
                Navigator.pop(context);
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
      propertiesCubit.dailyRentStartIndex = null;
      propertiesCubit.dailyRentEndIndex = null;
    });
  }
}
