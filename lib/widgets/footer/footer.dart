import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:takshashila/widgets/footer/footer_desk.dart';
import 'package:takshashila/widgets/footer/footer_mobile.dart';
import 'package:takshashila/widgets/footer/footer_tab.dart';

// ignore: must_be_immutable
class Footer extends StatelessWidget {
  Footer({super.key});

  double wid = 350;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: FooterMobile(),
      tablet: FooterTab(),
      desktop: FooterDesk(),
    );
  }
}
