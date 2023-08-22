import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../main.dart';

class WalletDataItem extends StatelessWidget {
  final int value;
  final String date;
  final bool type;
  const WalletDataItem({
    super.key,
    required this.value,
    required this.date,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: screenSize.width * .75,
              child: Text(
                type
                    ? 'Your balance has been charged with $value at ${date.substring(0, 10)} - ${date.substring(11, 16)}'
                    : '$value was withdrawn from your account at ${date.substring(0, 10)} - ${date.substring(11, 16)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17.sp,
                  color: Colors.black.withOpacity(.6),
                ),
              ),
            ),
            type
                ? const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  )
          ],
        ),
        Divider(
          color: Colors.grey,
          indent: 20.w,
          endIndent: 20.w,
        ),
      ],
    );
  }
}
