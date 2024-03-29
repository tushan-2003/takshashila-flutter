import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Positioned.fill(
              child: Container(
            decoration: const BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.yellow, Colors.orange])),
          )),
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text("Login"),
          )
        ],
      ),
    );
  }
}
