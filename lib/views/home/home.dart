import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_form/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:takshashila/models/course_model.dart';
import 'package:takshashila/services/database.dart';

import 'package:takshashila/widgets/carousel/carousel.dart';
import 'package:takshashila/widgets/centerview/center_view.dart';
import 'package:takshashila/widgets/faqs/faq.dart';
import 'package:takshashila/widgets/footer/footer.dart';
import 'package:takshashila/widgets/navigationbar/navigation_bar.dart';

import '../../services/authentication.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Map<String, dynamic>? studData;
  List<CourseModel> courseHome = [];

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
        courseHome.add(CourseModel(
            element["Course Name"],
            element["Mentor Name"],
            element["Description"],
            element["Price"],
            lesList,
            element["Sales"]));
      });
    }
  }

  Future<void> loadUserData() async {
    final user = context.read<Authenticate>().user;
    final stud = await UserData().loginUser(user.uid);

    setState(() {
      studData = stud;
    });

    print(studData);
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Column(
                children: [
                  ScreenTypeLayout(
                    mobile: CarouselBanner(height: 250, wid: 350),
                    tablet: CarouselBanner(height: 400, wid: 750),
                    desktop: CarouselBanner(height: 500, wid: 1200),
                  ),
                  Center_View(
                      child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      //Teachers
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Text(
                            "Teachers",
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: SizedBox(
                          width: 1300,
                          child: TeacherCarousel(
                            child: courseHome,
                          ),
                        ),
                      ),
                      //FAQS
                      const SizedBox(
                        height: 50,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Text(
                            "FAQs",
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 1300,
                        child: FAQs(),
                      ),
                      //Reviews
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Text(
                            "Reviews",
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: SizedBox(width: 1300, child: ReviewCarousel()),
                      ),
                      //Footer
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  )),
                  Footer()
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
