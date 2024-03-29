import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  UserData();

  final CollectionReference students =
      FirebaseFirestore.instance.collection("students");
  final CollectionReference courses =
      FirebaseFirestore.instance.collection("courses");

  Future addUser(String uid, String fullname, String email) async {
    await students.doc(uid).set(
        {"Full Name": fullname, "Email": email, "Course": []});
  }

  Future addCourseByUser(String uid, String course, String mentor) async {
    await students.doc(uid).update({
      "Course": FieldValue.arrayUnion([
        {"course": "${course}", "mentor": "${mentor}"}
      ])
    });
    await courses
        .doc("${course} with ${mentor}")
        .update({"Sales": FieldValue.increment(1)});
    print("Course Added in profile");
  }

  Future loginUser(String uid) async {
    final snapshot = await students.doc(uid).get();
    final data = snapshot.data() as Map<String, dynamic>;
    return data;
  }
}

class Admin_Operation {
  final CollectionReference course =
      FirebaseFirestore.instance.collection("courses");

  Future addCourse(
    String course_name,
    String des,
    String mentor,
    double price,
  ) async {
    await course.doc("$course_name with $mentor").set({
      "Course Name": course_name,
      "Description": des,
      "Mentor Name": mentor,
      "Price": price,
      "Sales": 0,
    });
  }

  Future addLesson(
    String course_name,
    String mentor,
    double lesson,
    String lesson_name,
    String lesson_des,
  ) async {
    await course
        .doc("$course_name with $mentor")
        .collection("lessons")
        .doc("$lesson+1")
        .set({
      "Lesson": lesson + 1,
      "LessonDes": lesson_des,
      "LessonName": lesson_name
    });
  }
}
