import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/main.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_cubit.dart';
import 'package:untitled/shared/widgets/custome_button.dart';

abstract class CustomDialog {
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
