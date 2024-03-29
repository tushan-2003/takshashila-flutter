// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:takshashila/services/database.dart';
import 'package:takshashila/widgets/snackbar/snackbar.dart';

class Authenticate {
  final FirebaseAuth _auth;
  Authenticate(this._auth);

  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  Future<void> register(
      {required String email,
      required String fullname,
      required String password,
      required BuildContext context}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await UserData().addUser(user.uid, fullname, email);

      Navigator.pushReplacementNamed(context, "/login");
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
      } else if (e.code == "email-already-in-use") {}
      snackBar(context, e.message!);
    }
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      if (email == "admin" && password == "admin@2710") {
        Navigator.pushReplacementNamed(context, "/admin");
        // ignore: duplicate_ignore
      } else {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print('Login successful');
        Navigator.pushReplacementNamed(context, "/home");
        //  final args = await UserData(uid: 'user.uid').loginUser(user.uid);
        // ignore: use_build_context_synchronously
      }
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.message!);
    }
  }

  Future<void> signout(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, "/login");
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.message!);
    }
  }

  Future<void> forgotPassword(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      snackBar(context, "You will receive an email to change the password");
      Navigator.pushReplacementNamed(context, "/login");
    } catch (e) {
      snackBar(context, e.toString());
    }
  }
}
