import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});
  static const String routeName = "/faq";
  static const String name = "FAQs";

  // List -> Map
  final List<Map<String, String>> faqs = [
    {
      "question": "What is Uptodo?",
      "answer":
          "Uptodo is a simple todo app that helps you to manage your daily tasks."
    },
    {
      "question": "How to add a new task?",
      "answer":
          "To add a new task, click on the floating action button at the bottom right corner of the screen."
    },
    {
      "question": "How to delete a task?",
      "answer": "To delete a task, swipe the task to the left or right."
    },
    {
      "question": "How to mark a task as completed?",
      "answer":
          "To mark a task as completed, tap on the checkbox on the left side of the task."
    },
    {
      "question": "How to view completed tasks?",
      "answer":
          "To view completed tasks, tap on the filter icon at the top right corner of the screen and select 'Completed'."
    },
    {
      "question": "How to view active tasks?",
      "answer":
          "To view active tasks, tap on the filter icon at the top right corner of the screen and select 'Active'."
    },
    {
      "question": "How to view all tasks?",
      "answer":
          "To view all tasks, tap on the filter icon at the top right corner of the screen and select 'All'."
    },
    {
      "question": "How to view the details of a task?",
      "answer": "To view the details of a task, tap on the task."
    },
    {
      "question": "How to edit a task?",
      "answer":
          "To edit a task, tap on the task and then tap on the edit icon at the top right corner of the screen."
    },
    {
      "question": "How to change the theme?",
      "answer":
          "To change the theme, tap on the theme icon at the top right corner of the screen and select the theme you want."
    },
    {
      "question": "How to change the language?",
      "answer":
          "To change the language, tap on the language icon at the top right corner of the screen and select the language you want."
    },
    {
      "question": "How to sign out?",
      "answer":
          "To sign out, tap on the sign out icon at the top right corner of the screen."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(
        context: context,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset('assets/svg/icons/arrow-left.svg'),
        ),
        title: "FAQs",
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            initiallyExpanded: index == 0,
            title: Text(faqs[index]["question"]!),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(faqs[index]["answer"]!),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        ),
      ),
    );
  }
}
