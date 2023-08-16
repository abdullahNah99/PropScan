import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/shared/styles/app_colors.dart';

class CustomeImage extends StatelessWidget {
  final String? image;
  final double? height, width;
  final double? iconSize;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? iconColor;
  const CustomeImage({
    super.key,
    this.image,
    this.height,
    this.width,
    this.borderRadius,
    this.iconSize,
    this.margin,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 150.h,
      width: width ?? 150.w,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: borderRadius,
        image: image != null
            ? DecorationImage(fit: BoxFit.cover, image: AssetImage(image!))
            : null,
      ),
      child: image != null
          ? null
          : Icon(
              Icons.person,
              size: iconSize ?? 35.sp,
              color: iconColor ?? AppColors.color2,
            ),
    );
  }
}

class CustomeNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? height, width;
  final double? iconSize;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BoxFit? fit;
  const CustomeNetworkImage({
    super.key,
    this.imageUrl,
    this.height,
    this.width,
    this.borderRadius,
    this.iconSize,
    this.margin,
    this.color,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height * .25,
      width: width ?? MediaQuery.of(context).size.width * .25,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.shade200,
        borderRadius: borderRadius,
        image: imageUrl != null
            ? DecorationImage(
                fit: fit ?? BoxFit.scaleDown,
                image:
                    NetworkImage('http://192.168.43.37:8000/upload/$imageUrl'),
              )
            : null,
      ),
      child: imageUrl != null
          ? null
          : Icon(
              Icons.person,
              size: iconSize ?? 35.sp,
              color: AppColors.defaultColor,
            ),
    );
  }
}

class CustomeFileImage extends StatelessWidget {
  final String filePath;
  final double? height, width;
  final double? iconSize;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  const CustomeFileImage({
    super.key,
    required this.filePath,
    this.height,
    this.width,
    this.borderRadius,
    this.iconSize,
    this.margin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200.h,
      width: width ?? 160.w,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: color ?? Colors.transparent,
        borderRadius: borderRadius ?? BorderRadius.circular(25.r),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(
              File(filePath),
            )),
      ),
    );
  }
}
