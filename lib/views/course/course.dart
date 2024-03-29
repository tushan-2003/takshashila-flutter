import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_form/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:takshashila/models/course_model.dart';
import 'package:takshashila/services/database.dart';
import 'package:takshashila/views/course/course_desk.dart';
import 'package:takshashila/views/course/course_mobile.dart';
import 'package:takshashila/views/course/course_tab.dart';
import 'package:takshashila/widgets/centerview/center_view.dart';
import 'package:takshashila/widgets/navigationbar/navigation_bar.dart';
import '../../services/authentication.dart';
import '../../widgets/footer/footer.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  Map<String, dynamic>? studData;
  List<CourseModel> courseList = [];
  Future<void> loadUserData() async {
    final user = context.read<Authenticate>().user;
    final stud = await UserData().loginUser(user.uid);

    setState(() {
      studData = stud;
    });
  }

  Future loadCourse() async {
    final course = await FirebaseFirestore.instance.collection("courses").get();
    for (var element in course.docs) {
      final lessons = await FirebaseFirestore.instance
          .collection("courses")
          .doc(element.id)
          .collection("lessons")
          .get();
      List<LessonModel> lesList = [];
      for (var les in lessons.docs) {
        lesList.add(
            LessonModel(les["LessonName"], les["Lesson"], les["LessonDes"]));
      }
      setState(() {
        courseList.add(CourseModel(
            element["Course Name"],
            element["Mentor Name"],
            element["Description"],
            element["Price"],
            lesList,
            element["Sales"]));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
    loadCourse();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<Authenticate>().user;

    return Scaffold(
      drawer: Drawer(
        backgroundColor: HexColor("#ff7e5f"),
        // Define your drawer content here
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Center(
                  child: Column(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 90,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/user"),
                    child: Text(
                      studData?["Full Name"],
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  )
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(
                  Icons.home,
                  size: 30,
                ),
                minLeadingWidth: 5,
                title: const Text(
                  "Home",
                  style: TextStyle(fontSize: 25),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/home");
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(
                  Icons.videocam,
                  size: 30,
                ),
                minLeadingWidth: 5,
                title: const Text(
                  "Course",
                  style: TextStyle(fontSize: 25),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/course");
                },
              ),
            ),
            // Add more items as needed
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [HexColor("#ff7e5f"), HexColor("#feb47b")])),
        child: SingleChildScrollView(
          child: Column(children: [
            Navigation_Bar(
              fullname: studData?["Full Name"] ?? user.uid,
            ),
            Center_View(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Text(
                        "Courses",
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                  ),
                  ScreenTypeLayout(
                    mobile: CourseMobile(
                        containerHeight: (courseList.length / 1).ceil() * 510.0,
                        courseList: courseList),
                    desktop: CourseDesk(
                        containerHeight: (courseList.length / 3).ceil() * 510.0,
                        courseList: courseList),
                    tablet: CourseTab(
                        containerHeight: (courseList.length / 2).ceil() * 510.0,
                        courseList: courseList),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Footer()
          ]),
        ),
      ),
    );
  }
}
