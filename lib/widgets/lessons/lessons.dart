import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:takshashila/models/course_model.dart';

/*
class Lessons extends StatefulWidget {
  const Lessons({super.key});

  @override
  State<Lessons> createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  @override
  Widget build(BuildContext context) {
    return Accordion(children: [
      AccordionSection(
        header: const Text(
          "Lesson no. ",
          style: TextStyle(fontSize: 20),
        ),
        content: ListTile(
          leading: Image.asset(
            "assets/images/bgimg_1.jpeg",
          ),
          minLeadingWidth: 50,
          title: const Text(
            "Lesson name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          subtitle: const Text(
              "Lorem ipsum dolor uctus accumsan tortor posuere ac  trisdin nib Ultrices eros in cursus turpis massa tincidunt dui ut ornare. Faucibus purus in massa tempor nec feugiat.",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        ),
      ),
      AccordionSection(
        header: const Text(
          "Lesson no. ",
          style: TextStyle(fontSize: 20),
        ),
        content: ListTile(
          leading: Image.asset(
            "assets/images/bgimg_1.jpeg",
          ),
          minLeadingWidth: 50,
          title: const Text(
            "Lesson name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          subtitle: const Text(
              "Lorem ipsum dolor uctus accumsan tortor posuere ac  trisdin nib Ultrices eros in cursus turpis massa tincidunt dui ut ornare. Faucibus purus in massa tempor nec feugiat.",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        ),
      ),
      AccordionSection(
        header: const Text(
          "Lesson no. ",
          style: TextStyle(fontSize: 20),
        ),
        content: ListTile(
          leading: Image.asset(
            "assets/images/bgimg_1.jpeg",
          ),
          minLeadingWidth: 50,
          title: const Text(
            "Lesson name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          subtitle: const Text(
              "Lorem ipsum dolor uctus accumsan tortor posuere ac  trisdin nib Ultrices eros in cursus turpis massa tincidunt dui ut ornare. Faucibus purus in massa tempor nec feugiat.",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        ),
      ),
      AccordionSection(
        header: const Text(
          "Lesson no. ",
          style: TextStyle(fontSize: 20),
        ),
        content: ListTile(
          leading: Image.asset(
            "assets/images/bgimg_1.jpeg",
          ),
          minLeadingWidth: 50,
          title: const Text(
            "Lesson name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          subtitle: const Text(
              "Lorem ipsum dolor uctus accumsan tortor posuere ac  trisdin nib Ultrices eros in cursus turpis massa tincidunt dui ut ornare. Faucibus purus in massa tempor nec feugiat.",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        ),
      ),
      AccordionSection(
        header: const Text(
          "Lesson no. ",
          style: TextStyle(fontSize: 20),
        ),
        content: ListTile(
          leading: Image.asset(
            "assets/images/bgimg_1.jpeg",
          ),
          minLeadingWidth: 50,
          title: const Text(
            "Lesson name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          subtitle: const Text(
              "Lorem ipsum dolor uctus accumsan tortor posuere ac  trisdin nib Ultrices eros in cursus turpis massa tincidunt dui ut ornare. Faucibus purus in massa tempor nec feugiat.",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        ),
      ),
      AccordionSection(
        header: const Text(
          "Lesson no. ",
          style: TextStyle(fontSize: 20),
        ),
        content: ListTile(
          leading: Image.asset(
            "assets/images/bgimg_1.jpeg",
          ),
          minLeadingWidth: 50,
          title: const Text(
            "Lesson name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          subtitle: const Text(
              "Lorem ipsum dolor uctus accumsan tortor posuere ac  trisdin nib Ultrices eros in cursus turpis massa tincidunt dui ut ornare. Faucibus purus in massa tempor nec feugiat.",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        ),
      ),
      AccordionSection(
        header: const Text(
          "Lesson no. ",
          style: TextStyle(fontSize: 20),
        ),
        content: ListTile(
          leading: Image.asset(
            "assets/images/bgimg_1.jpeg",
          ),
          minLeadingWidth: 50,
          title: const Text(
            "Lesson name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          subtitle: const Text(
              "Lorem ipsum dolor uctus accumsan tortor posuere ac  trisdin nib Ultrices eros in cursus turpis massa tincidunt dui ut ornare. Faucibus purus in massa tempor nec feugiat.",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        ),
      ),
      AccordionSection(
        header: const Text(
          "Lesson no. ",
          style: TextStyle(fontSize: 20),
        ),
        content: ListTile(
          leading: Image.asset(
            "assets/images/bgimg_1.jpeg",
          ),
          minLeadingWidth: 50,
          title: const Text(
            "Lesson name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          subtitle: const Text(
              "Lorem ipsum dolor uctus accumsan tortor posuere ac  trisdin nib Ultrices eros in cursus turpis massa tincidunt dui ut ornare. Faucibus purus in massa tempor nec feugiat.",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
        ),
      ),
    ]);
  }
}
*/
class LessonList extends StatelessWidget {
  final List<LessonModel> les;
  const LessonList({super.key, required this.les});

  @override
  Widget build(BuildContext context) {
    return Accordion(children: generateLessonList(les.length, les));
  }

  List<AccordionSection> generateLessonList(int count, List<LessonModel> lst) {
    List<AccordionSection> leslist = [];
    for (int i = 0; i < count; i++) {
      leslist.add(AccordionSection(
          header: Text(
            "${lst[i].lessonno}. ${lst[i].lessonname}",
            style: const TextStyle(fontSize: 20),
          ),
          content:
              Text(lst[i].lessondes, style: const TextStyle(fontSize: 13))));
    }
    return leslist;
  }
}
