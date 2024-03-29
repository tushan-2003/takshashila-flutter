import 'package:firebase_storage/firebase_storage.dart';

class CourseModel {
  final String course;
  final String mentor;
  final String des;
  final double price;
  final double sales;
  final List<LessonModel> lessons;

  CourseModel(
    this.course,
    this.mentor,
    this.des,
    this.price,
    this.lessons,
    this.sales,
  );

  Future<String> mentorURL() async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("/Course/$course with $mentor/mentorImage");

    ListResult res = await ref.listAll();
    List<Future<String>> imgURL = [];
    List<String> ntwrk;
    for (var item in res.items) {
      imgURL.add(item.getDownloadURL());
    }

    ntwrk = await Future.wait(imgURL);
    return ntwrk[0];
  }
}

class LessonModel {
  final String lessonname;
  final double lessonno;
  final String lessondes;

  LessonModel(this.lessonname, this.lessonno, this.lessondes);
}
