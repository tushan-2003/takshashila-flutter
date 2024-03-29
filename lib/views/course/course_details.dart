import 'package:credit_card_form/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:takshashila/services/database.dart';
import 'package:takshashila/views/course/course_details_desk.dart';
import 'package:takshashila/views/course/course_details_mobile.dart';
import 'package:takshashila/views/course/course_details_tab.dart';
import 'package:takshashila/widgets/faqs/faq.dart';
import 'package:takshashila/widgets/lessons/lessons.dart';
import '../../models/course_model.dart';
import '../../services/authentication.dart';
import '../../widgets/footer/footer.dart';
import '../../widgets/navigationbar/navigation_bar.dart';

class CourseDetails extends StatefulWidget {
  final CourseModel course;
  const CourseDetails({super.key, required this.course});

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  String? image;
  Map<String, dynamic>? studData;

  Future<void> loadUserData() async {
    final user = context.read<Authenticate>().user;
    final stud = await UserData().loginUser(user.uid);

    setState(() {
      studData = stud;
    });
  }

  Future getLink() async {
    Reference img = FirebaseStorage.instance.ref().child(
        "/Course/${widget.course.course} with ${widget.course.mentor}/courseImage");

    ListResult imglink = await img.listAll();

    if (imglink.items.isNotEmpty) {
      // Fetch the URL of the first item in the list
      String imageUrl = await imglink.items.first.getDownloadURL();
      print(imageUrl);
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
    loadUserData();
    getLink();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<Authenticate>().user;
    CourseModel courseDetail = widget.course;
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
                    mobile: CourseDetailsMobileImage(
                      image: image,
                    ),
                    tablet: CourseDetailsTabImage(
                      image: image,
                    ),
                    desktop: CourseDetailsDeskImage(
                      image: image,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ScreenTypeLayout(
                    tablet: CourseDetailsTab(courseDetail: courseDetail),
                    mobile: CourseDetailsMobile(courseDetail: courseDetail),
                    desktop: CourseDetailsDesk(courseDetail: courseDetail),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      leading: Icon(
                        Icons.videocam,
                      ),
                      title: Text(
                        "Lessons",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: LessonList(
                      les: courseDetail.lessons,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ListTile(
                      leading: Icon(
                        Icons.videocam,
                      ),
                      title: Text(
                        "FAQs",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: FAQs(),
                  ),
                  Footer(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
