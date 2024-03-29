import 'package:flutter/material.dart';

class NavbarLogo extends StatelessWidget {
  final double wid;
  const NavbarLogo({super.key, required this.wid});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: wid,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
        child: Image.asset(
          "assets/images/takshashila.png",
          width: 200,
        ),
      ),
    );
  }
}
