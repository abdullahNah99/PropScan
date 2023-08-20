import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/properties_screen/cubit/properties_cubit.dart';

class DailyRentItem extends StatelessWidget {
  final void Function()? onTap;
  final int index;
  final String day;
  final String date;
  final String status;
  final PropertiesCubit propertiesCubit;
  const DailyRentItem({
    super.key,
    required this.index,
    required this.day,
    required this.date,
    required this.status,
    required this.propertiesCubit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: propertiesCubit.getDailyRentItemColor(index: index),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                day,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  decoration: propertiesCubit.reservedDates.contains(index)
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                date,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  decoration: propertiesCubit.reservedDates.contains(index)
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
