import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/modules/add_property_screen/widgets/page_view_item.dart';
import '../cubit/add_property_cubit.dart';

class CustomPageView extends StatelessWidget {
  final AddPropertyCubit addPropertyCubit;
  const CustomPageView({super.key, required this.addPropertyCubit});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      height: addPropertyCubit.selectedTypeIndex == 0
          ? 580.h
          : addPropertyCubit.selectedTypeIndex == 1
              ? 485.h
              : 270.h,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: addPropertyCubit.controller,
        children: List.generate(
          addPropertyCubit.types.length,
          (index) => PageViewItem(cubit: addPropertyCubit),
        ),
      ),
    );
  }
}
