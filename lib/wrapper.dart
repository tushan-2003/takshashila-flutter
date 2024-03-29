import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:takshashila/views/home/home.dart';
import 'package:takshashila/views/welcome/welcome.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return HomeView();
    } else {
      return const Welcome();
    }
  }
}
