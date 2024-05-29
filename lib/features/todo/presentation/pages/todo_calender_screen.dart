import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:uptodo/features/todo/presentation/widgets/todo_item.dart';

class TodoCalenderScreen extends StatefulWidget {
  const TodoCalenderScreen({super.key});

  static const String routeName = "/todo-calender";
  static const String name = "Todo Calender";

  @override
  State<TodoCalenderScreen> createState() => _TodoCalenderScreenState();
}

class _TodoCalenderScreenState extends State<TodoCalenderScreen> {
  DateTime _selectedDay = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  List<Todo> _selectedEvents = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is! TodoLoaded) return const Center(child: CircularProgressIndicator());
        final todos = state.todos;
        final eventMap = <DateTime, List<Todo>>{};
        for (final todo in todos) {
          if (todo.target == null || ![TodoStatus.notCompleted, TodoStatus.completed].contains(todo.status)) continue;
          final date = DateTime.utc(todo.target!.year, todo.target!.month, todo.target!.day);
          eventMap.putIfAbsent(date, () => <Todo>[]).add(todo);
        }

        List<Todo> getEventsForDay(DateTime day) => eventMap[day] ?? [];
        _selectedEvents = getEventsForDay(_selectedDay);

        return Scaffold(
          appBar: globalAppBar(
            context: context,
            toolbarHeight: 40,
            title: "Calendar",
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TableCalendar(
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: true,
                    titleCentered: true,
                  ),
                  locale: 'en_US',
                  calendarStyle: CalendarStyle(
                    todayTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                    todayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.6)),
                      // borderRadius: BorderRadius.circular(4.0),
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(4.0),
                    ),
                    markersMaxCount: 1,
                  ),
                  firstDay: DateTime.utc(2024, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _selectedDay,
                  eventLoader: getEventsForDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() => _selectedDay = selectedDay);
                      _selectedEvents = getEventsForDay(selectedDay);
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() => _calendarFormat = format);
                    }
                  },
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _selectedEvents.isEmpty
                      ? const Center(child: Text("No events"))
                      : ListView.separated(
                          itemCount: _selectedEvents.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 5),
                          itemBuilder: (context, index) {
                            return TodoItem(todo: _selectedEvents[index]);
                          },
                        ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
