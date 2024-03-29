import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takshashila/services/authentication.dart';
import 'package:takshashila/widgets/login/user_input.dart';

class LoginViewMobile extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  const LoginViewMobile({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 30),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
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
                        fontSize: 13, decoration: TextDecoration.underline),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginViewTab extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController password;
  const LoginViewTab({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 50),
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
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
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
                        fontSize: 17, decoration: TextDecoration.underline),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
