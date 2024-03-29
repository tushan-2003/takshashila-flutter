import 'package:flutter/material.dart';
import 'package:takshashila/widgets/navigationbar/navbar_logo.dart';

class NavBarMobile extends StatelessWidget {
  const NavBarMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                color: Colors.white,
                icon: const Icon(Icons.menu)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: NavbarLogo(
              wid: 210,
            ),
          ),
        ],
      ),
    );
  }
}
