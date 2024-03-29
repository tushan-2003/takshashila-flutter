import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:takshashila/models/course_model.dart';

class CourseDetailsDesk extends StatelessWidget {
  final CourseModel courseDetail;
  const CourseDetailsDesk({super.key, required this.courseDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: StaggeredGrid.count(
          crossAxisCount: 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    // color: Colors.orange,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: ListTile(
                              title: Text(
                                courseDetail.course,
                                style: const TextStyle(fontSize: 35),
                              ),
                              subtitle: Text(courseDetail.mentor,
                                  style: const TextStyle(fontSize: 20)),
                              trailing: Column(
                                children: [
                                  Text("Rs.${courseDetail.price}",
                                      style: const TextStyle(fontSize: 17)),
                                  Text(
                                    "Rs.${courseDetail.price + 500}",
                                    style: const TextStyle(
                                        fontSize: 11,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 8, 0),
                            child: Text(
                              "Limited Period Offer : 30% off",
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: ListTile(
                              title: const Text(
                                "Description :",
                                style: TextStyle(fontSize: 25),
                              ),
                              subtitle: SingleChildScrollView(
                                child: Text(
                                  courseDetail.des,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            StaggeredGridTile.count(
                crossAxisCellCount: 1,
                mainAxisCellCount: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                              child: Text(
                            "Features",
                            style: TextStyle(fontSize: 35),
                          )),
                          const SizedBox(
                            height: 5,
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.star),
                                title: Text(
                                  "Learn from the Master ${courseDetail.mentor}",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              ListTile(
                                leading: const Icon(Icons.star),
                                title: Text(
                                    "${courseDetail.lessons.length} lessons for easy learning",
                                    style: const TextStyle(fontSize: 15)),
                              ),
                              const ListTile(
                                leading: Icon(Icons.star),
                                title: Text(
                                    "All Lessons can be accessed offline",
                                    style: TextStyle(fontSize: 15)),
                              ),
                              const ListTile(
                                leading: Icon(Icons.star),
                                title: Text("Access from any device",
                                    style: TextStyle(fontSize: 15)),
                              ),
                              const ListTile(
                                leading: Icon(Icons.star),
                                title: Text("Certificate of completion",
                                    style: TextStyle(fontSize: 15)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "/payment",
                                      arguments: courseDetail);
                                },
                                child: const Text(
                                  "Buy Now",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }
}

class CourseDetailsDeskImage extends StatelessWidget {
  final String? image;
  const CourseDetailsDeskImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: image != null
            ? Image.network(
                image!,
                height: 500,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
