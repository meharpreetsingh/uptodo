import 'package:flutter/material.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';

class TodoScreen extends StatelessWidget {
  static const String routeName = "/";
  static const String name = "Todo";
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(
        context: context,
        showProfileIcon: true,
        title: "Index",
      ),
      body: const Center(
        child: Text("Todo Screen"),
      ),
    );
  }
}
