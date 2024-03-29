import 'package:flutter/material.dart';

// ignore: camel_case_types
class Center_View extends StatelessWidget {
  final Widget child;
  const Center_View({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      //alignment: Alignment.topCenter,
      child: child,
    );
  }
}
