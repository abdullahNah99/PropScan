import 'package:flutter/material.dart';

class CustomeErrorWidget extends StatelessWidget {
  final String errorMessage;
  const CustomeErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage));
  }
}
