import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takshashila/services/authentication.dart';
import 'package:takshashila/widgets/login/user_input.dart';

class LoginViewDesk extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  const LoginViewDesk({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 50, color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(children: [
                  UserInput(
                    controller: email,
                    password: false,
                    labelText: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  UserInput(
                      controller: password,
                      labelText: "Password",
                      pass_visible: true,
                      password: true),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/forgot_password");
                      },
                      child: const Text(
                        "Forgot Password",
                        style: TextStyle(
                            fontSize: 15, decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.read<Authenticate>().login(
                            email: email.text,
                            password: password.text,
                            context: context);
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(395, 55),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w300),
                      )),
                  const SizedBox(
                    height: 13,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/register");
                    },
                    child: const Text(
                      "Don`t have an account ? Register Yourself",
                      style: TextStyle(
                          fontSize: 15, decoration: TextDecoration.underline),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
