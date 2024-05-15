import 'package:flutter/material.dart';
import 'package:uptodo/common/widgets/main_bottom_nav_bar.dart';

class CommonMainScreen extends StatelessWidget {
  const CommonMainScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: child,
    );
  }
}
