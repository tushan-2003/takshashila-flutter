import 'package:flutter/material.dart';

class Admin_SignOut extends StatelessWidget {
  const Admin_SignOut({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Sign Out",
          style: TextStyle(fontSize: 50),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/login");
              },
              child: const Text("Sign Out"),
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/admin");
              },
              child: const Text("Cancel"),
            )
          ],
        )
      ],
    ));
  }
}
