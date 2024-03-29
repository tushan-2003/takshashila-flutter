import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:takshashila/models/user_model.dart';

class Admin_Home extends StatefulWidget {
  const Admin_Home({super.key});

  @override
  State<Admin_Home> createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home> {
  List<Student> allusers = [];

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    print(allusers.length);
    return Column(
      children: [
        const Text(
          "Users",
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: allusers.length,
            itemBuilder: (BuildContext context, int index) {
              String fullname = allusers[index].fullname;
              String email = allusers[index].email;
              List<dynamic> courses_list = allusers[index].course;
              return UserCard(fullname, email, courses_list);
            },
          ),
        ),
      ],
    );
  }

  Future getUsers() async {
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection("students").get();
    setState(() {
      allusers = data.docs
          .map((doc) => Student(
              course: doc["Course"],
              email: doc["Email"],
              fullname: doc["Full Name"]))
          .toList();
    });
  }
}

Widget UserCard(String fullname, String email, List course) {
  String course_data = "";

  for (var data in course) {
    course_data += "${data["course"]}, ";
  }
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        minLeadingWidth: 100,
        leading: const SizedBox(
            width: 40,
            height: 100,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/profile.png"),
            )),
        title: Text(fullname),
        subtitle: Text("Courses: ${course_data}"),
        trailing: Text(email),
      ),
    ),
  );
}
