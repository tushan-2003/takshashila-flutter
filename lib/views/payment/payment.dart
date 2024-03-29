import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:takshashila/models/course_model.dart';
import 'package:takshashila/services/authentication.dart';
import 'package:takshashila/views/payment/payment_desk.dart';
import 'package:takshashila/views/payment/payment_mobile.dart';
import 'package:takshashila/views/payment/payment_tab.dart';

import '../../services/database.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map<String, dynamic>? studData;
  Future<void> loadUserData() async {
    final user = context.read<Authenticate>().user;
    final stud = await UserData().loginUser(user.uid);

    setState(() {
      studData = stud;
    });

    print(studData);
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<Authenticate>().user;
    CourseModel sel_course =
        ModalRoute.of(context)?.settings.arguments as CourseModel;

    return Scaffold(
        body: ScreenTypeLayout(
          mobile: PaymentMobile(
              studData: studData, sel_course: sel_course, uid: user.uid),
          desktop: PaymentDesk(
              studData: studData, sel_course: sel_course, uid: user.uid),
          tablet: PaymentTab(
              studData: studData, sel_course: sel_course, uid: user.uid),
        ));
  }
}
