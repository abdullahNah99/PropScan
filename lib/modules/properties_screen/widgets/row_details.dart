import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowDetails extends StatelessWidget {
  final IconData icon;
  final String text;
  const RowDetails({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.green,
            size: 20,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
