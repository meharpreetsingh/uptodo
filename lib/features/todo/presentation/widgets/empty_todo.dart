import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyTodoList extends StatelessWidget {
  final bool? isEmpty;
  final String? message;
  const EmptyTodoList({
    super.key,
    this.isEmpty,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/svg/empty_list.svg"),
        Text(
          (isEmpty != null && isEmpty!) ? "No Results" : "What do you want to do?",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Text(
          message ?? "Tap + to add your tasks",
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
