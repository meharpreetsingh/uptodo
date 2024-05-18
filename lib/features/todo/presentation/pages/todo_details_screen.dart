import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/common/widgets/custom_icon_button.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';

class TodoDetailScreen extends StatelessWidget {
  const TodoDetailScreen({super.key, required this.todo});
  final Todo todo;
  static const String routeName = "/todo-detail";
  static const String name = "Todo Detail Screen";

  ListTile _todoDetailTile(
    BuildContext context, {
    Widget? icon,
    String? title,
    String? buttonText,
  }) {
    return ListTile(
      horizontalTitleGap: 5,
      leading: IconButton(
        icon: icon ?? const Icon(Icons.access_alarm),
        onPressed: () {},
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: Text(title ?? "Task Time: "),
      trailing: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: Text(buttonText ?? "Button"),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(
          context: context,
          title: "Todo",
          leading: Center(
            child: CustomIconButton(
              onPressed: () => context.pop(),
              child: const Icon(Icons.close),
            ),
          ),
          actions: [
            CustomIconButton(onPressed: () {}, child: const Icon(Icons.refresh)),
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            horizontalTitleGap: 5,
            minVerticalPadding: 5,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            title: Text(
              todo.title,
              style: const TextStyle(fontSize: 21),
            ),
            titleAlignment: ListTileTitleAlignment.top,
            subtitle: Text(
              todo.description,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFAFAFAF),
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit_note),
            ),
          ),
        ],
      ),
    );
  }
}
