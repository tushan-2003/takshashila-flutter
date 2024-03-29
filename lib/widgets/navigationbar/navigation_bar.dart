// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'package:takshashila/widgets/navigationbar/navigation_bar_desktop_tab.dart';
import 'package:takshashila/widgets/navigationbar/navigation_bar_mobile.dart';
import 'package:takshashila/widgets/navigationbar/navigation_bar_tablet.dart';

class Navigation_Bar extends StatefulWidget {
  final String fullname;
  const Navigation_Bar({super.key, required this.fullname});

  @override
  State<Navigation_Bar> createState() => _Navigation_BarState();
}

class _Navigation_BarState extends State<Navigation_Bar> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: NavBarDesk(
        fullname: widget.fullname,
      ),
      tablet: NavBarTab(
        fullname: widget.fullname,
      ),
      mobile: const NavBarMobile(),
    );
  }
}
