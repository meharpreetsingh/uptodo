import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/common/widgets/custom_icon_button.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/presentation/bloc/todo_bloc.dart';

class TodoDetailScreen extends StatelessWidget {
  const TodoDetailScreen({super.key, required this.todo});
  final Todo todo;
  static const String routeName = "/todo-detail";
  static const String name = "Todo Detail Screen";

  String getSubtitle(DateTime dueDateTime) {
    String subtitle = "";
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    if (dueDateTime.day == now.day) {
      subtitle = "Today At ${DateFormat(' hh:mm a').format(dueDateTime)}";
    } else if (DateFormat('yyyy-MM-dd').format(dueDateTime) ==
        DateFormat('yyyy-MM-dd').format(tomorrow)) {
      subtitle = "Tomorrow At ${DateFormat(' hh:mm a').format(dueDateTime)}";
    } else {
      subtitle = DateFormat('E, d MMM, hh:mm a').format(dueDateTime);
    }
    return subtitle;
  }

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
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        Todo stateTodo = (state as TodoLoaded).todos.firstWhere((element) => element.id == todo.id);
        return Scaffold(
          appBar: globalAppBar(
              context: context,
              leading: Center(
                child: CustomIconButton(
                  onPressed: () => context.pop(),
                  child: const Icon(Icons.close),
                ),
              ),
              actions: [
                CustomIconButton(onPressed: () {}, child: const Icon(Icons.refresh)),
              ]),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  horizontalTitleGap: 5,
                  minVerticalPadding: 5,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  titleAlignment: ListTileTitleAlignment.top,
                  leading: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    value: stateTodo.status == TodoStatus.completed,
                    onChanged: (bool? value) {
                      if (value == null) return;
                      context.read<TodoBloc>().add(
                            UpdateTodoEvent(
                              stateTodo.copyWith(
                                status: value ? TodoStatus.completed : TodoStatus.notCompleted,
                              ),
                            ),
                          );
                    },
                  ),
                  title: Text(
                    stateTodo.title,
                    style: const TextStyle(fontSize: 21),
                  ),
                  subtitle: Text(
                    stateTodo.description,
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
                const SizedBox(height: 10),
                if (stateTodo.target != null)
                  _todoDetailTile(
                    context,
                    title: "Task Time: ",
                    icon: SvgPicture.asset(
                      "assets/svg/icons/clock.svg",
                      height: 21,
                      width: 21,
                      fit: BoxFit.contain,
                    ),
                    buttonText: getSubtitle(stateTodo.target!),
                  ),
                // TODO: Add Category Logic Here
                _todoDetailTile(
                  context,
                  title: "Task Priority: ",
                  icon: SvgPicture.asset(
                    "assets/svg/icons/flag.svg",
                    height: 21,
                    width: 21,
                    fit: BoxFit.contain,
                  ),
                  buttonText: stateTodo.priority == 0 ? "Default" : "${stateTodo.priority}",
                ),
                Expanded(child: Container()),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        icon: SvgPicture.asset(
                          "assets/svg/icons/trash.svg",
                          width: 18,
                          height: 18,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        onPressed: () {
                          context
                              .read<TodoBloc>()
                              .add(UpdateTodoEvent(todo.copyWith(status: TodoStatus.deleted)));
                          context.pop();
                        },
                        label: Text(
                          "Delete Task",
                          style: TextStyle(color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        icon: SvgPicture.asset(
                          stateTodo.status == TodoStatus.archived
                              ? "assets/svg/icons/archive-slash.svg"
                              : "assets/svg/icons/archive.svg",
                          width: 18,
                          height: 18,
                          color: stateTodo.status == TodoStatus.archived
                              ? Theme.of(context).colorScheme.onSurface
                              : Colors.yellow,
                        ),
                        onPressed: () {
                          context.read<TodoBloc>().add(
                                UpdateTodoEvent(
                                  todo.copyWith(
                                      status: stateTodo.status == TodoStatus.archived
                                          ? TodoStatus.notCompleted
                                          : TodoStatus.archived),
                                ),
                              );
                          context.pop();
                        },
                        label: Text(
                          stateTodo.status == TodoStatus.archived ? "Un-Archive" : "Archive",
                          style: TextStyle(
                            color: stateTodo.status == TodoStatus.archived
                                ? Theme.of(context).colorScheme.onSurface
                                : Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text("Id: ${stateTodo.id}", textAlign: TextAlign.center),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}
