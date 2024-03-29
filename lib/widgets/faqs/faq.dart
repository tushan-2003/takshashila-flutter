import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';

class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
  @override
  Widget build(BuildContext context) {
    return Accordion(children: generateFAQ(5));
  }
}

List<AccordionSection> generateFAQ(int count) {
  List<AccordionSection> faq = [];
  for (int i = 1; i <= count; i++) {
    faq.add(AccordionSection(
        header: const Text(
          "Question",
          style: TextStyle(fontSize: 20),
        ),
        content: const Text("Answer", style: TextStyle(fontSize: 20))));
  }
  return faq;
}
