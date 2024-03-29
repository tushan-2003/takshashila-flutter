import 'package:flutter/material.dart';
import 'package:takshashila/widgets/navigationbar/navbar_item.dart';
import 'package:takshashila/widgets/navigationbar/navbar_logo.dart';
import 'package:takshashila/widgets/profile/profile.dart';

class NavBarTab extends StatefulWidget {
  final String fullname;
  const NavBarTab({super.key, required this.fullname});

  @override
  State<NavBarTab> createState() => _NavBarTabState();
}

class _NavBarTabState extends State<NavBarTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavbarLogo(
            wid: 230,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavBarItems(
                title: "Home",
                route: '/home',
                size: 19,
              ),
              NavBarItems(
                title: "Courses",
                route: '/course',
                size: 19,
              ),
              ProfileLogo(
                fullname: widget.fullname,
                wid: 130,
                size: 12,
              ),
              const SizedBox(
                width: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
