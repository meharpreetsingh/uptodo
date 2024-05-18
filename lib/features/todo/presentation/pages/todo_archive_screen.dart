import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:uptodo/features/todo/presentation/widgets/empty_todo.dart';

class TodoArchiveScreen extends StatelessWidget {
  const TodoArchiveScreen({super.key});

  static const String routeName = "/todo-archive";
  static const String name = "Todo Archive Screen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is! TodoLoaded) return const Center(child: CircularProgressIndicator());
        final archivedTodos = state.todos.where((element) => element.status == TodoStatus.archived).toList();
        return Scaffold(
          appBar: globalAppBar(
            context: context,
            title: "Archive",
            showBackButton: true,
          ),
          body: archivedTodos.isEmpty
              ? const Center(child: EmptyTodoList(isEmpty: true, message: "No Archived Todos"))
              : ListView.builder(
                  itemCount: archivedTodos.length,
                  itemBuilder: (context, index) {
                    final todo = archivedTodos[index];
                    return Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ListTile(
                        title: Text(todo.title),
                        subtitle: Text(todo.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: SvgPicture.asset(
                                "assets/svg/icons/trash.svg",
                                color: Theme.of(context).colorScheme.error,
                                width: 18,
                                height: 18,
                              ),
                              onPressed: () {
                                context.read<TodoBloc>().add(UpdateTodoEvent(todo.copyWith(status: TodoStatus.deleted)));
                              },
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: SvgPicture.asset(
                                "assets/svg/icons/archive-slash.svg",
                                color: Colors.amberAccent,
                                width: 18,
                                height: 18,
                              ),
                              onPressed: () {
                                context.read<TodoBloc>().add(UpdateTodoEvent(todo.copyWith(status: TodoStatus.notCompleted)));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
