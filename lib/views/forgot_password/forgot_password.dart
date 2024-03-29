import 'package:credit_card_form/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takshashila/services/authentication.dart';
import 'package:takshashila/widgets/login/user_input.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();

  void _forgotPassword() {
    context.read<Authenticate>().forgotPassword(context, email.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [HexColor("#F2994A"), HexColor("#F2C94C")])),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Forgot Password",
                  style: TextStyle(fontSize: 40),
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
                    ElevatedButton(
                        onPressed: _forgotPassword,
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(395, 55),
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white),
                        child: const Text(
                          "Proceed",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w300),
                        )),
                    const SizedBox(
                      height: 13,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
