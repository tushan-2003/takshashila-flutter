import 'package:credit_card_form/utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:takshashila/views/login_view/login_view_desk.dart';
import 'package:takshashila/views/login_view/login_view_mobile_tab.dart';

class LoginView extends StatefulWidget {
  static String route = '/login';
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [HexColor("#F2994A"), HexColor("#F2C94C")])),
        child: ScreenTypeLayout(
            mobile: LoginViewMobile(email: email, password: password),
            tablet: LoginViewTab(email: email, password: password),
            desktop: LoginViewDesk(email: email, password: password)),
      ),
    );
  }
}
