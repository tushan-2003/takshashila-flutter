import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavBarItems extends StatelessWidget {
  final String title;
  final String route;
  double size = 20;
  NavBarItems(
      {super.key,
      required this.title,
      required this.route,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, route);
        },
        child: Text(
          title,
          style: TextStyle(fontSize: size, color: Colors.white),
        ),
      ),
    );
  }
}
