import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Submit extends StatefulWidget {
  final String buttonText;
  String? user;
  String? password;
  Submit({super.key, required this.buttonText, this.user, this.password});

  @override
  State<Submit> createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          debugPrintSynchronously(widget.user);
          debugPrintSynchronously(widget.password);
        },
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 55),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white),
        child: Text(
          widget.buttonText,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        ));
  }
}

class Register extends StatefulWidget {
  final String buttonText;
  const Register({super.key, required this.buttonText});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 55),
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white),
        child: Text(
          widget.buttonText,
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        ));
  }
}
