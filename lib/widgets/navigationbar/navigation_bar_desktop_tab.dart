import 'package:flutter/material.dart';
import 'package:takshashila/widgets/navigationbar/navbar_item.dart';
import 'package:takshashila/widgets/navigationbar/navbar_logo.dart';
import 'package:takshashila/widgets/profile/profile.dart';

class NavBarDesk extends StatefulWidget {
  final String fullname;
  NavBarDesk({super.key, required this.fullname});

  @override
  State<NavBarDesk> createState() => _NavBarDeskState();
}

class _NavBarDeskState extends State<NavBarDesk> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavbarLogo(
            wid: 250,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavBarItems(
                title: "Home",
                route: '/home',
                size: 25,
              ),
              const SizedBox(
                width: 30,
              ),
              NavBarItems(
                title: "Courses",
                route: '/course',
                size: 25,
              ),
              const SizedBox(
                width: 30,
              ),
              ProfileLogo(
                fullname: widget.fullname,
                wid: 200,
                size: 17,
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          )
        ],
      ),
    );
  }
}
