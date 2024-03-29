import 'package:credit_card_form/utils.dart';
import 'package:flutter/material.dart';

import '../login_view/login_view.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 1000), // Adjust the duration as needed
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    // Start the animation when the page loads
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [HexColor("#F2994A"), HexColor("#F2C94C")])),
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child: child,
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/Takshashila.png",
                  scale: 1,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 60,
                  width: 220,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, LoginView.route);
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(395, 55),
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w300),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
