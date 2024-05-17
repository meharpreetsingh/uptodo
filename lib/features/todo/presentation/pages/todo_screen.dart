import 'package:flutter/material.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';

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
      body: Padding(
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
          ],
        ),
      ),
    );
  }
}
