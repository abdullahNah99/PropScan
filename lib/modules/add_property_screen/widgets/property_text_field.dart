import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/shared/styles/app_colors.dart';

class PropertyTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? hintText;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final double? width;
  final int? maxLines;
  const PropertyTextField({
    super.key,
    this.keyboardType,
    this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.width,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 70.w,
      child: TextFormField(
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return 'required';
          }
          return null;
        },
        onChanged: onChanged,
        maxLines: maxLines ?? 1,
        keyboardType: keyboardType ?? TextInputType.number,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.color2,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.defaultColor),
          ),
          // prefixIcon: const Icon(
          //   Icons.attach_money_outlined,
          //   color: AppColors.color1,
          // ),
        ),
      ),
    );
  }
}

class PropertyInfoItem extends StatelessWidget {
  final String text;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  const PropertyInfoItem({
    super.key,
    required this.text,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: AppColors.color2,
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        PropertyTextField(
          onChanged: onChanged,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
