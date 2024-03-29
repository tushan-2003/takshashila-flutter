import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takshashila/services/authentication.dart';
import 'package:takshashila/views/admin/admin.dart';
import 'package:takshashila/views/course/course.dart';
import 'package:takshashila/views/feedback/feedback.dart';
import 'package:takshashila/views/forgot_password/forgot_password.dart';
import 'package:takshashila/views/payment/payment.dart';
//import 'package:takshashila/views/course/course_details.dart';

import 'package:takshashila/views/register/register.dart';

import 'package:takshashila/views/home/home.dart';
import 'package:takshashila/views/login_view/login_view.dart';
import 'package:takshashila/views/user_panel/user_panel.dart';
import 'package:takshashila/views/welcome/welcome.dart';
//import 'package:takshashila/wrapper.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authenticate>(
          create: (_) => Authenticate(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<Authenticate>().authState,
            initialData: null)
      ],
      child: MaterialApp(
        routes: {
          LoginView.route: (context) => const LoginView(),
          Register_View.route: (context) => const Register_View(),
          "/admin": (context) => const AdminPage(),
          "/home": (context) => const HomeView(),
          "/course": (context) => const CourseView(),
          //  "/course_details": (context) => const CourseDetails(),
          "/payment": (context) => const Payment(),
          "/user": (context) => const UserPanel(),
          "/feedback": (context) => FeedbackForm(),
          "/forgot_password": (context) => const ForgotPassword(),
        },
        home: const Wrapper(),
        debugShowCheckedModeBanner: false,
        title: 'Takshashila',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme:
              Theme.of(context).textTheme.apply(fontFamily: "HindiSiliguri"),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final firebaseUser = context.watch<User?>();

        if (firebaseUser != null) {
          print('User is authenticated. Displaying HomeView.');
          return const HomeView();
        } else {
          print('User is not authenticated. Displaying Welcome.');
          return const Welcome();
        }
      },
    );
  }
}
