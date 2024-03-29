// ignore_for_file: camel_case_types, non_constant_identifier_names, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:takshashila/services/database.dart';

class Add_Course extends StatefulWidget {
  const Add_Course({Key? key}) : super(key: key);

  @override
  State<Add_Course> createState() => _Add_CourseState();
}

class _Add_CourseState extends State<Add_Course> {
  // ignore: non_constant_identifier_names
  final TextEditingController course_name = TextEditingController();
  final TextEditingController mentor_name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController lesson_count = TextEditingController();
  final TextEditingController describe = TextEditingController();

  // final TextEditingController lesson = TextEditingController();
  int les_count = 0;
  List<TextEditingController> lesson_name_controllers = [];
  List<TextEditingController> lesson_des_controllers = [];

  List<FilePickerResult> selectedFiles = [];

  FilePickerResult? coursePhoto;
  FilePickerResult? mentorPhoto;
  void addVideoFile(FilePickerResult file) {
    setState(() {
      selectedFiles.add(file);
    });
  }

  void clear() {
    course_name.clear();
    mentor_name.clear();
    price.clear();
    lesson_count.clear();
    describe.clear();
    //lesson.clear();
    lesson_des_controllers.clear();
    setState(() {
      les_count = 0;
      coursePhoto = null;
      mentorPhoto = null;
    });
  }

  Future addCourseFiles() async {
    await Admin_Operation().addCourse(course_name.text, describe.text,
        mentor_name.text, double.parse(price.text));

    for (int i = 0; i < lesson_name_controllers.length; i++) {
      await Admin_Operation().addLesson(
          course_name.text,
          mentor_name.text,
          i.toDouble(),
          lesson_name_controllers[i].text,
          lesson_des_controllers[i].text);
    }

    final coursePath =
        "Course/${course_name.text} with ${mentor_name.text}/courseImage/${coursePhoto!.files.single.name}";
    final mentorPath =
        "Course/${course_name.text} with ${mentor_name.text}/mentorImage/${mentorPhoto!.files.single.name}";

    Uint8List? courseBytes = coursePhoto!.files.single.bytes;
    Uint8List? mentorBytes = coursePhoto!.files.single.bytes;
    try {
      await FirebaseStorage.instance.ref(coursePath).putData(courseBytes!);
      await FirebaseStorage.instance.ref(mentorPath).putData(mentorBytes!);
    } catch (e) {
      print(e);
    }

    for (FilePickerResult? fileResult in selectedFiles) {
      if (fileResult != null) {
        final path =
            "Course/${course_name.text} with ${mentor_name.text}/${fileResult.files.single.name}";
        Uint8List? fileBytes = fileResult.files.single.bytes;

        try {
          await FirebaseStorage.instance.ref(path).putData(fileBytes!);
          print("Uploaded: ${fileResult.files.single.name}");
        } catch (e) {
          print("Error uploading ${fileResult.files.single.name}: $e");
        }
      }
    }

    print("Course Added!");
    clear();
  }

  Future<void> _addCourse() async {
    await addCourseFiles();
    await Future.delayed(
        const Duration(seconds: 1)); // Simulate delay for demonstration
  }

  Future updateCourse(String course_name, String mentor) async {
    final course = await FirebaseFirestore.instance
        .collection("courses")
        .doc("$course_name with $mentor");
    if (price.text.isNotEmpty) {
      await course.update({"Price": price.text});
      print("Price updated");
      price.clear();
    } else if (describe.text.isNotEmpty) {
      await course.update({"Description": describe.text});
      print("Description updated");
      describe.clear();
    } else if (describe.text.isNotEmpty && price.text.isNotEmpty) {
      await course.update({"Price": price.text, "Description": describe.text});
      print("Description updated");
      describe.clear();
    } else if (lesson_count.text.isNotEmpty) {
      print("Lessons cannot be updated");
    } else {
      print("No such course exist");
    }

    print("Course Updated!");
    clear();
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < les_count; i++) {
      lesson_name_controllers.add(TextEditingController());
      lesson_des_controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Center(
          child: Text(
            "Add Courses",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: admin_input(course_name, "Course")),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      if (coursePhoto != null)
                        // ignore: avoid_unnecessary_containers
                        Container(
                          child: Center(
                              child: Text(
                            coursePhoto!.files.single.name,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          )),
                        ),
                      ElevatedButton(
                          onPressed: () async {
                            final result =
                                await FilePicker.platform.pickFiles();
                            if (result == null) return;
                            setState(() {
                              coursePhoto = result;
                            });
                          },
                          child: const Text("Select Image")),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: admin_input(mentor_name, "Mentor")),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      if (mentorPhoto != null)
                        Center(
                            child: Text(
                          mentorPhoto!.files.single.name,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        )),
                      ElevatedButton(
                          onPressed: () async {
                            final result =
                                await FilePicker.platform.pickFiles();
                            if (result == null) return;
                            setState(() {
                              mentorPhoto = result;
                            });
                          },
                          child: const Text("Select Mentor")),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(child: admin_input(price, "Price")),
                  const SizedBox(width: 10),
                  Expanded(child: admin_input(lesson_count, "No. of Lessons")),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              admin_input(describe, "Description"),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      les_count = int.parse(lesson_count.text);
                      lesson_des_controllers.clear();
                      lesson_name_controllers.clear();
                      for (var i = 0; i < les_count; i++) {
                        lesson_name_controllers.add(TextEditingController());
                        lesson_des_controllers.add(TextEditingController());
                      }
                    });
                  },
                  child: const Text("Save")),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text("Lessons")],
              ),
              ListView.builder(
                  itemCount: les_count,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: LessonInput(
                        les_name: "Lesson",
                        les_des: "Description",
                        des_controller: lesson_des_controllers[index],
                        name_controller: lesson_name_controllers[index],
                        fileSelected: addVideoFile,
                      ),
                    );
                  }),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: addCourseFiles,
                      child: const Text("Add Course")),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          updateCourse(course_name.text, mentor_name.text),
                      child: const Text("Update Course")),
                ],
              )
            ],
          ),
        ),
        FutureBuilder(
          future: _addCourse(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return const Text("");
            } else {
              return const Text("Error Adding Course");
            }
          },
        )
      ],
    );
  }
}

TextField admin_input(TextEditingController controller, String label) {
  return label != "Description"
      ? TextField(
          controller: controller,
          style: const TextStyle(fontSize: 10),
          // maxLines: 3,
          decoration: InputDecoration(
            enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide(width: 3)),
            focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide(width: 3)),
            labelText: label,
          ),
        )
      : TextField(
          controller: controller,
          style: const TextStyle(fontSize: 10),
          maxLines: 3,
          decoration: InputDecoration(
            enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide(width: 3)),
            focusedBorder:
                const OutlineInputBorder(borderSide: BorderSide(width: 3)),
            labelText: label,
          ),
        );
}

class LessonInput extends StatefulWidget {
  final String les_name;
  final String les_des;
  final TextEditingController name_controller;
  final TextEditingController des_controller;
  final Function(FilePickerResult) fileSelected;

  const LessonInput(
      {super.key,
      required this.les_des,
      required this.les_name,
      required this.name_controller,
      required this.des_controller,
      required this.fileSelected});

  @override
  State<LessonInput> createState() => _LessonInputState();
}

class _LessonInputState extends State<LessonInput> {
  String? fileName;

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileName = result.files.first.name;
      });
      widget.fileSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  admin_input(widget.name_controller, widget.les_name),
                  const SizedBox(
                    height: 10,
                  ),
                  admin_input(widget.des_controller, widget.les_des),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                if (fileName != null)
                  Center(
                      child: Text(
                    fileName!,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  )),
                ElevatedButton(
                  onPressed: selectFile,
                  child: const Text("Select File"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
