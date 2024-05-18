import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/presentation/pages/todo_details_screen.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});
  final Todo todo;

  String getSubtitle(DateTime dueDateTime) {
    String subtitle = "";
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    if (dueDateTime.day == now.day) {
      subtitle = "Today At ${DateFormat(' hh:mm a').format(dueDateTime)}";
    } else if (DateFormat('yyyy-MM-dd').format(dueDateTime) == DateFormat('yyyy-MM-dd').format(tomorrow)) {
      subtitle = "Tomorrow At ${DateFormat(' hh:mm a').format(dueDateTime)}";
    } else {
      subtitle = DateFormat('E, d MMM, hh:mm a').format(dueDateTime);
    }
    return subtitle;
  }

  Widget getPriorityTag(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/icons/flag.svg",
            color: Theme.of(context).colorScheme.onSurface,
          ),
          Text(
            todo.priority.toString(),
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
          horizontalTitleGap: 5, // leading [gap] title
          contentPadding: const EdgeInsets.only(left: 5, right: 10),
          visualDensity: VisualDensity.compact,
          leading: Checkbox(
            visualDensity: VisualDensity.compact,
            value: todo.status == TodoStatus.completed,
            onChanged: (bool? value) {},
          ),
          title: Text(
            todo.title,
            style: const TextStyle(fontSize: 16),
          ),
          subtitle: todo.target != null
              ? Row(
                  children: [
                    if (todo.target != null) Text(getSubtitle(todo.target!)) else Container(),
                    Expanded(child: Container()),
                    // TODO: Add Category Tag
                    getPriorityTag(context),
                  ],
                )
              : null,
          trailing: todo.target == null ? getPriorityTag(context) : null,
          onTap: () {
            context.push(TodoDetailScreen.routeName, extra: todo);
          }),
    );
  }
}
