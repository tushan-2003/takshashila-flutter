import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String fullname;
  final String email;
  final List course;
  Student({required this.fullname, required this.email, required this.course});

  factory Student.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Student(
        fullname: data["Full Name"],
        email: data["Email"],
        course: data["Course"]);
  }
}
