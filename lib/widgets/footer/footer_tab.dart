import 'package:flutter/material.dart';

class FooterTab extends StatelessWidget {
  const FooterTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
            child: Image.asset(
              "assets/images/Takshashila.png",
              width: 250,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Where Art Meets Talent",
            style:
                TextStyle(fontSize: 15, letterSpacing: 2, color: Colors.white),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
            child: Text(
              "Follow Us On ",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
              child: SizedBox(
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/images/facebook.png",
                        width: 30,
                      ),
                      Image.asset(
                        "assets/images/insta.png",
                        width: 30,
                      ),
                      Image.asset(
                        "assets/images/linked.png",
                        width: 30,
                      ),
                      Image.asset(
                        "assets/images/twiiter.png",
                        width: 30,
                      ),
                      Image.asset(
                        "assets/images/youtube.png",
                        width: 30,
                      ),
                    ],
                  ))),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Table(
              children: [
                TableRow(children: [
                  const TableCell(
                    child: Center(
                      child: Text(
                        "Copyright Claim",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/feedback");
                        },
                        child: const Text(
                          "FeedBack",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ]),
                const TableRow(children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        "Careers",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        "Contact Us",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ]),
                const TableRow(children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        "Privacy Policy",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        "Terms & Conditions",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Text(
              "© 2023 Takshashila, Inc.",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )
        ]),
      ),
    );
  }
}
