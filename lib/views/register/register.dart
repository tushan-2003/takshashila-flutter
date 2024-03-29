import 'package:credit_card_form/utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:takshashila/views/register/register_desk.dart';
import 'package:takshashila/views/register/register_mobile_tab.dart';

// ignore: camel_case_types
class Register_View extends StatefulWidget {
  static String route = '/register';
  const Register_View({super.key});

  @override
  State<Register_View> createState() => _Register_ViewState();
}

// ignore: camel_case_types
class _Register_ViewState extends State<Register_View> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [HexColor("#F2994A"), HexColor("#F2C94C")])),
        child: ScreenTypeLayout(
            tablet: RegisterViewTab(
                fullname: fullname,
                email: email,
                password: password,
                confirmpassword: confirmpassword),
            mobile: RegisterViewMobile(
                fullname: fullname,
                email: email,
                password: password,
                confirmpassword: confirmpassword),
            desktop: RegisterViewDesk(
                fullname: fullname,
                email: email,
                password: password,
                confirmpassword: confirmpassword)),
      ),
    );
  }
}
