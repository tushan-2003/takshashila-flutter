import 'package:credit_card_form/credit_card_form.dart';
import 'package:credit_card_form/utils.dart';
import 'package:flutter/material.dart';
import 'package:takshashila/models/course_model.dart';
import 'package:takshashila/services/database.dart';
import 'package:takshashila/widgets/snackbar/snackbar.dart';

// ignore: must_be_immutable
class PaymentTab extends StatelessWidget {
  final Map<String, dynamic>? studData;
  final CourseModel sel_course;
  final String uid;
  CreditCardResult? card;

  PaymentTab(
      {super.key,
      required this.studData,
      required this.sel_course,
      required this.uid});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: HexColor("fcf2d9"),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Student Details ",
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.person,
                            size: 29,
                          ),
                          title: const Text(
                            "Student Name : ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          trailing: Text(
                            studData?["Full Name"] ?? "XYZ",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.email,
                            size: 29,
                          ),
                          title: const Text(
                            "Student Email : ",
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: Text(
                            studData?["Email"] ?? "XYZ",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Payment Methods
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Payment Details ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        const ListTile(
                          leading: Icon(
                            Icons.payment,
                            size: 29,
                          ),
                          title: Text(
                            "Credit Card/ Debit Card ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CreditCardForm(
                            theme: CreditCardLightTheme(),
                            onChanged: (CreditCardResult result) {
                              card = result;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Order Details ",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.videocam,
                            size: 29,
                          ),
                          title: Text(
                            sel_course.course,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          trailing: Text(
                            "Rs.${sel_course.price}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: const Color.fromARGB(255, 231, 215, 215),
                alignment: Alignment.center,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Summary ",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w500),
                      ),
                      ListTile(
                        title: const Text("Original Price : ",
                            style: TextStyle(fontSize: 20)),
                        trailing: Text("Rs.${sel_course.price + 1000}",
                            style: const TextStyle(fontSize: 18)),
                      ),
                      const ListTile(
                        title: Text("Discounts : ",
                            style: TextStyle(fontSize: 20)),
                        trailing:
                            Text("Rs.1000", style: TextStyle(fontSize: 18)),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.black,
                      ),
                      ListTile(
                        title: const Text("Total :",
                            style: TextStyle(fontSize: 20)),
                        trailing: Text("Rs.${sel_course.price}",
                            style: const TextStyle(fontSize: 18)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius
                                          .zero, // Set border radius to zero
                                    ),
                                    fixedSize: const Size(400, 50),
                                    elevation: 4, // Shadow elev5tion
                                  ),
                                  onPressed: () async {
                                    if (card == null ||
                                        card!.cardHolderName.isEmpty ||
                                        card!.cardNumber.isEmpty ||
                                        card!.expirationMonth.isEmpty ||
                                        card!.expirationYear.isEmpty ||
                                        card!.cvc.isEmpty) {
                                      snackBar(
                                          context, "Fill the payment Details");
                                    } else {
                                      await UserData().addCourseByUser(uid,
                                          sel_course.course, sel_course.mentor);
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacementNamed(
                                          context, "/user");
                                    }
                                  },
                                  child: const Text(
                                    "Complete Checkout",
                                    style: TextStyle(fontSize: 15),
                                  )),
                            ),
                            const Text(
                              "*By completing your purchase, you agree to terms and conditions",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
