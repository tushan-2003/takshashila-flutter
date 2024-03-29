import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserInput extends StatefulWidget {
  bool pass_visible;
  TextEditingController controller;
  String labelText;
  bool password;

  UserInput({
    super.key,
    this.pass_visible = false,
    required this.controller,
    required this.labelText,
    required this.password,
  });

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  @override
  Widget build(BuildContext context) {
    return widget.password
        ? TextField(
            controller: widget.controller,
            cursorColor: Colors.black,
            style: const TextStyle(fontSize: 20, letterSpacing: 2),
            obscureText: widget.pass_visible,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(widget.pass_visible
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    widget.pass_visible = !widget.pass_visible;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(15)),
              contentPadding: const EdgeInsets.all(27),
              label: Text(
                widget.labelText,
                style: const TextStyle(
                    fontSize: 20, letterSpacing: 2, color: Colors.black),
              ),
            ),
          )
        : TextField(
            controller: widget.controller,
            cursorColor: Colors.black,
            style: const TextStyle(fontSize: 20, letterSpacing: 2),
            obscureText: widget.password,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(15)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(15)),
              contentPadding: const EdgeInsets.all(27),
              label: Text(
                widget.labelText,
                style: const TextStyle(
                    fontSize: 20, letterSpacing: 2, color: Colors.black),
              ),
            ),
          );
  }
}
