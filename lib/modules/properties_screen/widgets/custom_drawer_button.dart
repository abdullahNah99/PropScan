import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/shared/styles/app_colors.dart';

class CustomDrawerButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;
  final void Function() onPressed;
  final double? fontSize;
  const CustomDrawerButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.iconColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 4,
        fixedSize: Size(220.w, 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Icon(
            icon,
            size: 25.w,
            color: iconColor ?? AppColors.defaultColor,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 20.w,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
