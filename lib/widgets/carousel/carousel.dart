import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:takshashila/models/course_model.dart';
import 'package:takshashila/models/review_model.dart';
import 'package:takshashila/views/course/course_details.dart';

class CarouselBanner extends StatelessWidget {
  final double height;
  final double wid;
  final List<String> banner = [
    "assets/images/img1.jpg",
    "assets/images/img2.jpg",
    "assets/images/img3.jpg",
  ];
  CarouselBanner({super.key, required this.height, required this.wid});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: height,
          autoPlay: true,
          viewportFraction: 1.0), // mobile 300,tablet 400
      items: banner
          .map(
            (item) => ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                item,
                fit: BoxFit.cover,
                width: wid, //Mobile 450, tablet 750
                height: 800,
              ),
            ),
          )
          .toList(),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class TeacherCarousel extends StatelessWidget {
  final List<CourseModel> child;
  const TeacherCarousel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollcontroller = ScrollController();
    return SizedBox(
      height: 300, // desk 350 , tab 300
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: ListView.builder(
          controller: _scrollcontroller,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: child.length,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Teachers(teacher: child[index]),
          ),
        ),
      ),
    );
  }
}

class Teachers extends StatefulWidget {
  final CourseModel teacher;
  const Teachers({super.key, required this.teacher});

  @override
  State<Teachers> createState() => _TeachersState();
}

class _TeachersState extends State<Teachers> {
  String? image;

  Future getLink() async {
    Reference img = FirebaseStorage.instance.ref().child(
        "/Course/${widget.teacher.course} with ${widget.teacher.mentor}/mentorImage");

    ListResult imglink = await img.listAll();

    if (imglink.items.isNotEmpty) {
      // Fetch the URL of the first item in the list
      String imageUrl = await imglink.items.first.getDownloadURL();
      setState(() {
        image = imageUrl;
      });
    } else {
      return ''; // Return an empty string if there are no items
    }
  }

  @override
  void initState() {
    super.initState();
    getLink();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230, //desk 270 ,tab 230
      height: 700,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              // ignore: unnecessary_null_comparison
              child: image != null
                  ? Image.network(
                      image!,
                      fit: BoxFit.fill,
                      width: 380,
                      height: 1000,
                    )
                  : const CircularProgressIndicator(),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.teacher.mentor,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewCarousel extends StatefulWidget {
  ReviewCarousel({
    super.key,
  });

  @override
  State<ReviewCarousel> createState() => _ReviewCarouselState();
}

class _ReviewCarouselState extends State<ReviewCarousel> {
  List<Review_Model> reviewdata = [];

  Future fetchReview() async {
    QuerySnapshot reviewList =
        await FirebaseFirestore.instance.collection("reviews").get();
    setState(() {
      reviewdata = reviewList.docs
          .map((doc) => Review_Model(
              review: doc["Review"],
              reviewer: doc["Reviewer"],
              stars: doc["Stars"]))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchReview();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollcontroller = ScrollController();
    return SizedBox(
      height: 300,
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: ListView.builder(
          controller: _scrollcontroller,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: reviewdata.length,
          itemBuilder: (_, index) => Review(
            review: reviewdata[index].review,
            reviewer: reviewdata[index].reviewer,
            star: reviewdata[index].stars,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Review extends StatelessWidget {
  String reviewer = "Reviewer";
  int star = 0;
  String review =
      "Lorem ipsum dolor sit amet, constlit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc consequat interdum varius sit. Augue eget arcu dictum varius duis at consectetur. Hendrerit gravida rutrum quisque non tellus orci ac auctor augue. Diam sollicitudin tempor id eu nisl. Ut placerat orci nulla pellentesque dignissim enim. Varius vel pharetra vel turpis nunc. Tristique senectus et netus et malesuada fames. Condimentum lacinia quis vel eros donec ac. Turpis massa sed elementum tempus. Sed vulputate odio ut enim blandit volutpat. Odio morbi quis commodo odio aenean sed adipiscing diam donec. Odio eu feugiat pretium nibh ipsum consequat nisl vel pretium.";
  Review(
      {super.key,
      required this.reviewer,
      required this.review,
      required this.star});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Card(
        color: Colors.orangeAccent,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: ListTile(
            title: Text(
              reviewer,
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      for (var i = 1; i <= star; i++)
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.star,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  review,
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CourseCard extends StatefulWidget {
  CourseModel course;
  CourseCard({super.key, required this.course});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  String? image = "";

  Future getLink() async {
    Reference img = FirebaseStorage.instance.ref().child(
        "/Course/${widget.course.course} with ${widget.course.mentor}/mentorImage");

    ListResult imglink = await img.listAll();

    if (imglink.items.isNotEmpty) {
      // Fetch the URL of the first item in the list
      String imageUrl = await imglink.items.first.getDownloadURL();
      setState(() {
        image = imageUrl;
      });
    } else {
      return ''; // Return an empty string if there are no items
    }
  }

  @override
  void initState() {
    super.initState();
    getLink();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CourseDetails(
                      course: widget.course,
                    )));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(
              image!,
            ), //AssetImage("assets/images/img2.jpg"),
            fit: BoxFit.cover,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: ListTile(
                  subtitle: Center(
                      child: Text(
                    widget.course.mentor,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  )),
                  title: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.5),
                    child: Text(
                      widget.course.course,
                      style: const TextStyle(fontSize: 35, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
