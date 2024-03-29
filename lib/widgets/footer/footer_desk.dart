import 'package:flutter/material.dart';

class FooterDesk extends StatelessWidget {
  const FooterDesk({super.key});

  @override
  Widget build(BuildContext context) {
    double wid = 350;
    return Container(
      height: 300,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                      child: Image.asset(
                        "assets/images/Takshashila.png",
                        width: 250,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Where Art Meets Talent",
                      style: TextStyle(
                          fontSize: 16, letterSpacing: 1, color: Colors.white),
                    ),
                  ],
                )),
                SizedBox(
                  width: wid,
                  //color: Colors.pink,
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 60, 0, 10),
                      child: Text(
                        "Follow Us On ",
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                            ]),
                      ),
                    )
                  ]),
                ),
                SizedBox(
                    width: wid + 50,
                    //color: Colors.green,
                    child: Table(
                      children: [
                        TableRow(children: [
                          const TableCell(
                            child: Center(
                              child: Text(
                                "Copyright Claim",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
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
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                "Contact Us",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ]),
                        const TableRow(children: [
                          TableCell(
                            child: Center(
                              child: Text(
                                "Privacy Policy",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    )),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
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
