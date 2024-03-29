import 'package:accordion/accordion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Admin_Course extends StatefulWidget {
  const Admin_Course({super.key});

  @override
  State<Admin_Course> createState() => _Admin_CourseState();
}

// ignore: camel_case_types
class _Admin_CourseState extends State<Admin_Course> {
  List<Course> courseList = [];

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Courses",
          style: TextStyle(fontSize: 20),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: courseList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CourseListCard(courseList[index]);
              }),
        )
      ],
    );
  }

  Future getCourses() async {
    final course = await FirebaseFirestore.instance.collection("courses").get();
    for (var element in course.docs) {
      final lessons = await FirebaseFirestore.instance
          .collection("courses")
          .doc(element.id)
          .collection("lessons")
          .get();
      List<Lessons> lesList = [];
      for (var les in lessons.docs) {
        lesList
            .add(Lessons(les["LessonName"], les["Lesson"], les["LessonDes"]));
      }
      print(lesList);
      setState(() {
        courseList.add(Course(
            element["Mentor Name"],
            element["Description"],
            element["Price"],
            element["Sales"],
            element["Course Name"],
            lesList));
        for (var i in courseList) {
          for (var j in i.les) {
            print(j.lessondes);
            print(j.lessonname);
            print(j.lessonno);
          }
        }
      });
    }
  }
}

class Course {
  final String coursename;
  final String mentorname;
  final String describe;
  final double price;
  final double sales;
  final List<Lessons> les;

  Course(this.mentorname, this.describe, this.price, this.sales,
      this.coursename, this.les);
}

class Lessons {
  final String lessonname;
  final double lessonno;
  final String lessondes;

  Lessons(this.lessonname, this.lessonno, this.lessondes);
}

Widget CourseListCard(Course course) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/profile.png"),
                radius: 60,
              ),
              title: Text("Course :  ${course.coursename}"),
              subtitle: Text("Mentor : ${course.mentorname}"),
              trailing:
                  Text("Price : ${course.price}\nSales : ${course.sales}"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text("Description : \n${course.describe}"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text("Lessons : ${course.les.length}"),
          ),
          LessonList(
            les: course.les,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    ),
  );
}

class LessonList extends StatelessWidget {
  final List<Lessons> les;
  const LessonList({super.key, required this.les});

  @override
  Widget build(BuildContext context) {
    return Accordion(children: generateLessonList(les.length, les));
  }

  List<AccordionSection> generateLessonList(int count, List<Lessons> lst) {
    List<AccordionSection> leslist = [];
    for (int i = 0; i < count; i++) {
      leslist.add(AccordionSection(
          header: Text(
            "${lst[i].lessonno}.${lst[i].lessonname}",
            style: const TextStyle(fontSize: 13),
          ),
          content:
              Text(lst[i].lessondes, style: const TextStyle(fontSize: 13))));
    }
    return leslist;
  }
}
