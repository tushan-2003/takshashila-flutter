// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_form/utils.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takshashila/models/user_model.dart';
import 'package:takshashila/services/authentication.dart';
import 'package:takshashila/services/database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:takshashila/widgets/snackbar/snackbar.dart';

class UserPanel extends StatefulWidget {
  const UserPanel({super.key});

  @override
  State<UserPanel> createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  Student? studData;
  Map<String, dynamic>? userdata;
  Future<void> loadUserData() async {
    final user = context.read<Authenticate>().user;
    final stud = await UserData().loginUser(user.uid);

    setState(() {
      userdata = stud;
      studData = Student(
          fullname: userdata!["Full Name"],
          email: userdata!["Email"],
          course: userdata!["Course"]);
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void _signOut(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign Out'),
            content: const Text('Do you really want to exit?'),
            actions: [
              TextButton(
                  onPressed: () {
                    context.read<Authenticate>().signout(context);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<Authenticate>().user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [HexColor("#ff7e5f"), HexColor("#feb47b")])),
            ),
            AppBar(
              title: Text(userdata?["Full Name"] ?? user.uid),
              backgroundColor: Colors
                  .transparent, // Set the background color of the AppBar to transparent
              elevation: 0, // Remove the elevation (shadow)
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 50, 8),
                  child: ElevatedButton(
                    onPressed: () {
                      _signOut(context);
                    },
                    child: const Text("Sign Out"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [HexColor("#ff7e5f"), HexColor("#feb47b")])),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    "Courses",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: studData == null
                      ? Center(
                          child: ElevatedButton(
                              child: Text("Reload"),
                              onPressed: () async {
                                DocumentSnapshot userData =
                                    await FirebaseFirestore.instance
                                        .collection("students")
                                        .doc(user.uid)
                                        .get();
                                if (userData.exists) {
                                  setState(() {
                                    studData =
                                        Student.fromDocumentSnapshot(userData);
                                  });
                                }
                              }),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: studData!.course.length,
                          itemBuilder: (context, index) {
                            print(studData!.course[index].toString());
                            return MyCourseCard(
                                context,
                                studData!.course[index]["course"],
                                studData!.course[index]["mentor"]);
                          }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget MyCourseCard(BuildContext context, String course, String mentor) {
  late Future<ListResult> files = FirebaseStorage.instance
      .ref('/Course/${course} with ${mentor}')
      .listAll();

  return Card(
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [HexColor("#E44D26"), HexColor("#F16529")])),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "Learn $course",
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(mentor),
              trailing: ElevatedButton(
                child: const Text("Download"),
                onPressed: () => downloadAllFiles(context, course, mentor),
              ),
            ),
            ExpansionTile(
              title: Center(child: Text("Lessons")),
              children: [
                FutureBuilder<ListResult>(
                    future: files,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final files = snapshot.data!.items;
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: files.length,
                              itemBuilder: (context, index) {
                                final file = files[index];
                                return ListTile(
                                  title: Text(file.name),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.download,
                                      color: Colors.black,
                                    ),
                                    onPressed: () =>
                                        downloadFile(context, file),
                                  ),
                                );
                              }),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(child: Text("Error Occured"));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Future downloadFile(BuildContext context, Reference ref) async {
  String path;
  if (kIsWeb) {
    window.open(await ref.getDownloadURL(), '_blank');
    return;
  } else {
    final tempDir = await getTemporaryDirectory();
    path = "${tempDir.path}/${ref.name}";
  }

  final url = await ref.getDownloadURL();
  await Dio().download(url, path);

  snackBar(context, "Downloaded ${ref.name}");
}

Future downloadAllFiles(
    BuildContext context, String course, String mentor) async {
  final storage = await FirebaseStorage.instance
      .ref("/Course/${course} with ${mentor}")
      .listAll();

  for (final file in storage.items) {
    await downloadFile(context, file);
  }
}
