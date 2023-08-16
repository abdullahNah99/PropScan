import 'package:flutter/material.dart';
import 'package:untitled/modules/add_property_screen/add_property_screen.dart';

class MyAdvertisementsView extends StatelessWidget {
  static const route = 'MyAdvertisementsView';
  const MyAdvertisementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddPropertyView.route);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class MyAdvertisementsViewBody extends StatelessWidget {
  const MyAdvertisementsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [],
    );
  }
}
