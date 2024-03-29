import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:takshashila/services/authentication.dart';
import 'package:takshashila/widgets/login/user_input.dart';

class RegisterViewDesk extends StatelessWidget {
  final TextEditingController fullname;
  final TextEditingController email;
  final TextEditingController password;
  final TextEditingController confirmpassword;

  const RegisterViewDesk(
      {super.key,
      required this.fullname,
      required this.email,
      required this.password,
      required this.confirmpassword});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(fontSize: 50),
              ),
              const SizedBox(
                height: 8,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(children: [
                  UserInput(
                      controller: fullname,
                      labelText: "Full Name",
                      password: false),
                  const SizedBox(
                    height: 10,
                  ),
                  UserInput(
                      controller: email, labelText: "Email", password: false),
                  const SizedBox(
                    height: 10,
                  ),
                  UserInput(
                    controller: password,
                    labelText: "Password",
                    password: true,
                    pass_visible: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  UserInput(
                    controller: confirmpassword,
                    labelText: "Confirm Password",
                    password: true,
                    pass_visible: true,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "By Registering, I Agree all the terms & conditions",
                    style: TextStyle(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (password.text == confirmpassword.text) {
                          context.read<Authenticate>().register(
                              email: email.text,
                              password: password.text,
                              context: context,
                              fullname: fullname.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(395, 55),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w300),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/login");
                      },
                      child: const Text(
                        "Already have an Account? Log In",
                        style: TextStyle(
                            fontSize: 15, decoration: TextDecoration.underline),
                      ),
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
