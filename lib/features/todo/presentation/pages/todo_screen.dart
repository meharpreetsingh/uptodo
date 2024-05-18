import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:uptodo/features/todo/presentation/widgets/empty_todo.dart';
import 'package:uptodo/features/todo/presentation/widgets/todo_item.dart';

class TodoScreen extends StatelessWidget {
  static const String routeName = "/";
  static const String name = "Todo";
  TodoScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(
        context: context,
        showProfileIcon: true,
        title: "Index",
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TodoLoaded && state.todos.isEmpty) {
            return const EmptyTodoList(isEmpty: true);
          }
          if (state is TodoError) {
            return EmptyTodoList(isEmpty: false, message: state.message);
          }
          if (state is TodoLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      border: const OutlineInputBorder(),
                      hintText: "Search for your task...",
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onChanged: (String? value) {},
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                      child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return TodoItem(todo: todo);
                    },
                  )),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
