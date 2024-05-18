import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:uptodo/features/todo/presentation/pages/todo_screen.dart';
import 'package:uptodo/features/todo/presentation/widgets/dialogs.dart';
import 'package:uuid/uuid.dart';

class TodoCreateScreen extends StatefulWidget {
  const TodoCreateScreen({Key? key}) : super(key: key);
  static const String routeName = '/todo/create';
  static const String name = 'Create Todo';

  @override
  State<TodoCreateScreen> createState() => _TodoCreateScreenState();
}

class _TodoCreateScreenState extends State<TodoCreateScreen> {
  bool isProcessing = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? targetDTime;
  String errorText = "";
  int priority = 1;
  bool alertUserOnTime = false;

  _getDateTimeInput({DateTime? initialDateTime}) async {
    final now = DateTime.now();
    DateTime? userDateInput = await _getDateInput(initialDateTime ?? now);
    TimeOfDay? userTimeInput = await _getTimeInput(TimeOfDay.fromDateTime(initialDateTime ?? now));
    if (userDateInput == null) {
      targetDTime = null;
    } else {
      targetDTime = DateTime(
        userDateInput.year,
        userDateInput.month,
        userDateInput.day,
        userTimeInput?.hour ?? 0,
        userTimeInput?.minute ?? 0,
      );
      setState(() => errorText = "");
    }
  }

  Future<DateTime?> _getDateInput(DateTime? initialDate) async {
    final now = DateTime.now();
    DateTime? userDateInput = await showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 730)),
    );
    if (userDateInput == null) {}
    log("[_getDate] $userDateInput");
    return userDateInput;
  }

  Future<TimeOfDay?> _getTimeInput(TimeOfDay? initialTime) async {
    TimeOfDay? userTimeInput = await showTimePicker(
      context: context,
      initialTime: initialTime ?? const TimeOfDay(hour: 0, minute: 0),
    );
    log("[_getTime] $userTimeInput");
    return userTimeInput;
  }

  bool _validateData() {
    if (_titleController.value.text.isEmpty) {
      setState(() => errorText = "Enter a 'title' first");
      return false;
    }
    return true;
  }

  _getPriority({int initialPriority = 1}) async {
    final todoPriority = await showDialog(
        context: context,
        builder: (context) {
          return GetPriorityDialog(initialPriority: initialPriority);
        });
    log("[_getPriority] $todoPriority");
    setState(() => priority = todoPriority);
  }

  _createTodo() {
    FocusScope.of(context).unfocus();
    if (_validateData() == false) return;
    final Todo todo = Todo(
      id: const Uuid().v4(),
      title: _titleController.value.text,
      description: _descriptionController.value.text,
      status: TodoStatus.notCompleted,
      target: targetDTime,
      priority: priority,
      createdAt: DateTime.now(),
    );
    log(todo.toString());
    context.read<TodoBloc>().add(CreateTodoEvent(todo));
    context.go(TodoScreen.routeName);
  }

  String getSubtitle(DateTime targetDTime) {
    String subtitle = "";
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    if (targetDTime.day == now.day) {
      subtitle = "Today At ${DateFormat(' hh:mm a').format(targetDTime)}";
    } else if (DateFormat('yyyy-MM-dd').format(targetDTime) == DateFormat('yyyy-MM-dd').format(tomorrow)) {
      subtitle = "Tomorrow At ${DateFormat(' hh:mm a').format(targetDTime)}";
    } else {
      subtitle = DateFormat('E, d MMM, hh:mm a').format(targetDTime);
    }
    return subtitle;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add Todo",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Title",
                ),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                maxLines: null,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Description (optional)",
                ),
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () => _getDateTimeInput(initialDateTime: targetDTime),
                    icon: const Icon(Icons.timer_outlined),
                    label: Text(
                      targetDTime != null ? getSubtitle(targetDTime!) : "Default",
                    ),
                  ),
                  Expanded(child: Container()),
                  if (targetDTime != null) ...[
                    const Text("Set Alert"),
                    Checkbox(
                      semanticLabel: "Set Alert",
                      value: alertUserOnTime,
                      onChanged: (bool? value) {
                        if (value == null) return;
                        setState(() => alertUserOnTime = value);
                      },
                    )
                  ],
                ],
              ),
              // const SizedBox(height: 10),
              // TextButton.icon(
              //   style: TextButton.styleFrom(
              //     foregroundColor: category != null ? category!.foreground : Theme.of(context).colorScheme.onSurface,
              //     backgroundColor: category != null ? category!.background : Theme.of(context).scaffoldBackgroundColor,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(4),
              //     ),
              //   ),
              //   onPressed: () => _getCategory(initialCategory: category),
              //   icon: Icon(category != null ? category!.icon : Icons.category_outlined),
              //   label: Text(category == null ? "Default" : category!.name),
              // ),
              const SizedBox(height: 10),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () => _getPriority(initialPriority: priority),
                icon: const Icon(Icons.flag_outlined),
                label: Text(priority == 1 ? "Default" : priority.toString()),
              ),
              const SizedBox(height: 10),
              if (errorText.isNotEmpty) ...[
                Text(
                  errorText,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                const SizedBox(height: 10),
              ],
              FilledButton(
                onPressed: _createTodo,
                child: const Text("Create"),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
