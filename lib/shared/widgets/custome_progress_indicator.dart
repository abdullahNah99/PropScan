import 'package:flutter/material.dart';
import '../styles/app_colors.dart';

class CustomeProgressIndicator extends StatelessWidget {
  final double? strokeWidth;
  final Color? color;
  const CustomeProgressIndicator({super.key, this.strokeWidth, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? AppColors.defaultColor,
        strokeWidth: strokeWidth ?? 4.0,
      ),
    );
  }
}
