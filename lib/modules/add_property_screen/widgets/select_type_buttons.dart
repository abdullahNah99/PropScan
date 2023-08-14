import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:untitled/modules/add_property_screen/cubit/add_property_cubit.dart';

class SelectTypeButtons extends StatelessWidget {
  final AddPropertyCubit cubit;
  const SelectTypeButtons({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        cubit.types.length,
        (index) {
          return Container(
            height: 45.h,
            width: 100.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: cubit.selectedTypeIndex == index
                    ? HexColor("#000c9c")
                    : HexColor("#009c90").withOpacity(.4)),
            child: TextButton(
              onPressed: () {
                cubit.selectPropertyType(index);
              },
              child: Text(
                cubit.types[index],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
