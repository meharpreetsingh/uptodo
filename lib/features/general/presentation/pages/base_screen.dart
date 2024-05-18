import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/common/widgets/main_bottom_nav_bar.dart';
import 'package:uptodo/core/services/injection_container.dart';
import 'package:uptodo/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:uptodo/features/todo/presentation/pages/todo_create_screen.dart';

class CommonMainScreen extends StatelessWidget {
  CommonMainScreen({super.key, required this.child});
  final Widget child;

  final uid = sl.get<FirebaseAuth>().currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<TodoBloc>()..add(GetTodosEvent(uid)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: const MainBottomAppBar(),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add",
          shape: const CircleBorder(),
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
          onPressed: () {
            context.go(TodoCreateScreen.routeName);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: child,
      ),
    );
  }
}
