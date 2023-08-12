import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/text_styles.dart';

class CustomDialogButton extends StatelessWidget {
  final void Function() onTap;
  final String text;
  const CustomDialogButton(
      {super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 200.w,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                text,
                style: Styles.textStyle20,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        const Divider(thickness: 1),
      ],
    );
  }
}
