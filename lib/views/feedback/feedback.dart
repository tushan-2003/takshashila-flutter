import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:takshashila/widgets/login/user_input.dart';
import 'package:takshashila/widgets/snackbar/snackbar.dart';

class FeedbackForm extends StatefulWidget {
  FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  TextEditingController reviewer = TextEditingController();

  TextEditingController review = TextEditingController();

  double _selectedValue = 0;
  // Default selected value
  void _onChanged(double value) {
    setState(() {
      _selectedValue = value;
    });
  }

  Future addReview() async {
    if (review.text.isNotEmpty && reviewer.text.isNotEmpty) {
      final CollectionReference rev =
          FirebaseFirestore.instance.collection("reviews");
      await rev.doc().set({
        "Review": review.text,
        "Reviewer": reviewer.text,
        "Stars": _selectedValue.toInt()
      });
      setState(() {
        _selectedValue = 0;
        review.clear();
        reviewer.clear();
      });
      Navigator.pushReplacementNamed(context, "/home");
    } else {
      snackBar(context, "Fill the Details");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
      ),
      backgroundColor: Colors.yellowAccent,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "FeedBack Form",
            style: TextStyle(fontSize: 50),
          ),
          SizedBox(
            height: 10,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                UserInput(
                    controller: reviewer, labelText: "Name", password: false),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text(
                    "Rate Us : ",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Text(
                    _selectedValue.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Slider(
                  inactiveColor: Colors.transparent,
                  activeColor: Colors.orange,
                  value: _selectedValue,
                  min: 0,
                  max: 5,
                  divisions: 5, // Optional: Divide the slider into intervals
                  onChanged: _onChanged,
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                    controller: review,
                    style: const TextStyle(fontSize: 13),
                    maxLines: 3,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(width: 3)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.orange, width: 3),
                      ),
                      contentPadding: const EdgeInsets.all(27),
                      label: Text(
                        "Your Review",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: addReview,
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(395, 55),
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white),
                    child: const Text(
                      "Submit",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                    )),
              ],
            ),
          )
        ],
      )),
    );
  }
}
