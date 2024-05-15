import 'package:flutter/material.dart';
import 'package:uptodo/common/widgets/bottom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  static const String name = "HomeScreen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: const CustomBottomAppBar(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        shape: const CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
        ),
        onPressed: () {
          // TODO: Add functionality
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
