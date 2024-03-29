import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileLogo extends StatelessWidget {
  final String fullname;
  final double wid;
  final double size;
  const ProfileLogo(
      {super.key,
      required this.fullname,
      required this.wid,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wid,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/user");
        },
        child: ListTile(
          tileColor: Colors.red,
          leading: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          minLeadingWidth: 30,
          title: Text(
            fullname,
            style: TextStyle(color: Colors.white, fontSize: size),
          ),
        ),
      ),
    );
  }
}
