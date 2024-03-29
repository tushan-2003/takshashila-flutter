import 'package:flutter/material.dart';
import 'package:takshashila/models/course_model.dart';
import 'package:takshashila/widgets/carousel/carousel.dart';

class CourseTab extends StatelessWidget {
  final double containerHeight;
  final List<CourseModel> courseList;
  const CourseTab(
      {super.key, required this.containerHeight, required this.courseList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: SizedBox(
          height: containerHeight,
          width: 1300,
          //  color: Colors.red,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: courseList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 500,
              ),
              itemBuilder: (_, index) => CourseCard(
                    course: courseList[index],
                  ))),
    );
  }
}
