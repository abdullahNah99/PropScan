import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/app_colors.dart';

// class CustomeTextField extends StatelessWidget {
//   final String? hintText;
//   final IconData? iconData;
//   final Function(String)? onChanged;
//   final TextInputType? keyboardType;
//   final bool? obscureText;
//   final Widget? suffixIcon;
//   final String? Function(String?)? validator;
//   final void Function()? onTap;
//   final bool disableFocusNode;
//   final String? initialValue;
//   final TextStyle? hintStyle;
//   final TextCapitalization textCapitalization;

//   final EdgeInsetsGeometry? contentPadding;
//   const CustomeTextField({
//     super.key,
//     this.hintText,
//     this.iconData,
//     this.onChanged,
//     this.keyboardType,
//     this.obscureText,
//     this.suffixIcon,
//     this.validator,
//     this.onTap,
//     this.disableFocusNode = false,
//     this.initialValue,
//     this.hintStyle,
//     this.contentPadding,
//     this.textCapitalization = TextCapitalization.none,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CustomeIcon(
//           icon: iconData ?? Icons.email,
//           size: 50,
//         ),
//         const SizedBox(width: 20),
//         SizedBox(
//           width: 260.w,
//           child: TextFormField(
//             validator: validator ??
//                 (value) {
//                   if (value?.isEmpty ?? true) {
//                     return 'required ...';
//                   }
//                   return null;
//                 },
//             onTap: onTap,
//             initialValue: initialValue,
//             focusNode: disableFocusNode ? AlwaysDisabledFocusNode() : null,
//             obscureText: obscureText ?? false,
//             keyboardType: keyboardType,
//             textCapitalization: textCapitalization,
//             onChanged: onChanged,
//             cursorColor: AppColors.defaultColor,
//             decoration: InputDecoration(
//               contentPadding: contentPadding,
//               hintText: hintText,
//               hintStyle: hintStyle ??
//                   TextStyle(
//                       fontSize: 20,
//                       color: AppColors.defaultColor.withOpacity(.6)),
//               suffixIcon: suffixIcon,
//               focusedBorder: getBorder(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   UnderlineInputBorder getBorder() {
//     return UnderlineInputBorder(
//       borderRadius: BorderRadius.circular(10),
//       borderSide: const BorderSide(
//         color: AppColors.defaultColor,
//       ),
//     );
//   }
// }

// class AlwaysDisabledFocusNode extends FocusNode {
//   @override
//   bool get hasFocus => false;
// }

class CustomeTextField extends StatelessWidget {
  final String? hintText;
  final IconData? iconData;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool disableFocusNode;
  final String? initialValue;
  final TextStyle? hintStyle;
  final TextCapitalization textCapitalization;
  final String? labelText;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? contentPadding;
  const CustomeTextField({
    super.key,
    this.hintText,
    this.iconData,
    this.onChanged,
    this.keyboardType,
    this.obscureText,
    this.suffixIcon,
    this.validator,
    this.onTap,
    this.disableFocusNode = false,
    this.initialValue,
    this.hintStyle,
    this.contentPadding,
    this.textCapitalization = TextCapitalization.none,
    this.labelText,
    this.labelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 340.w,
      child: TextFormField(
        validator: validator ??
            (value) {
              if (value?.isEmpty ?? true) {
                return 'required ...';
              }
              return null;
            },
        onTap: onTap,
        initialValue: initialValue,
        focusNode: disableFocusNode ? AlwaysDisabledFocusNode() : null,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        onChanged: onChanged,
        cursorColor: AppColors.defaultColor,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          hintText: hintText,
          hintStyle: hintStyle ??
              TextStyle(
                  fontSize: 20, color: AppColors.defaultColor.withOpacity(.6)),
          labelText: labelText,
          labelStyle: labelStyle ??
              const TextStyle(
                color: AppColors.defaultColor,
                fontSize: 22,
              ),
          suffixIcon: suffixIcon,
          focusedBorder: getOutLineInputBorder(),
          border: getOutLineInputBorder(),
        ),
      ),
    );
  }

  UnderlineInputBorder getUnderLineInputBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: AppColors.defaultColor,
      ),
    );
  }

  OutlineInputBorder getOutLineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: const BorderSide(
        color: AppColors.defaultColor,
        style: BorderStyle.solid,
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
