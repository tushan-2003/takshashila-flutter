import 'package:flutter/material.dart';

class CheckTerms extends StatefulWidget {
  const CheckTerms({super.key});

  @override
  State<CheckTerms> createState() => _CheckTermsState();
}

class _CheckTermsState extends State<CheckTerms> {

  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
      child: Checkbox(
        checkColor: Colors.white,
        activeColor: Colors.black,
          value: value,
          onChanged: (bool? value) {
            setState(() {
              this.value = value!;
            });
          }),
    );
  }
}
