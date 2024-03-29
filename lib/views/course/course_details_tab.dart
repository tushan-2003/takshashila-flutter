import 'package:flutter/material.dart';

import 'package:takshashila/models/course_model.dart';

class CourseDetailsTab extends StatelessWidget {
  final CourseModel courseDetail;
  const CourseDetailsTab({super.key, required this.courseDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                // color: Colors.orange,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: ListTile(
                      title: Text(
                        courseDetail.course,
                        style: const TextStyle(fontSize: 35),
                      ),
                      subtitle: Text(courseDetail.mentor,
                          style: const TextStyle(fontSize: 20)),
                      trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/payment",
                                arguments: courseDetail);
                          },
                          child: const Text(
                            "Buy Now",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: ListTile(
                      title: const Text(
                        "Limited Period Offer",
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      ),
                      trailing: Column(
                        children: [
                          Text("Rs.${courseDetail.price}",
                              style: const TextStyle(fontSize: 18)),
                          Text(
                            "Rs.${courseDetail.price + 500}",
                            style: const TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ],
                      ),
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
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          title: Text("All Lessons can be accessed offline",
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
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CourseDetailsTabImage extends StatelessWidget {
  final String? image;
  const CourseDetailsTabImage({super.key, this.image});

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
