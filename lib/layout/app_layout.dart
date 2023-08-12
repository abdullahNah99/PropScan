import 'package:flutter/material.dart';

class appLayout extends StatelessWidget {
  List<BottomNavigationBarItem> bottomitem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.request_page_outlined),
      label: 'Requests',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.inventory),
      label: 'Invoices',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  appLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
