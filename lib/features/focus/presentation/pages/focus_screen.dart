import 'package:flutter/material.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';
import 'package:uptodo/features/focus/presentation/widgets/app_usage.dart';
import 'package:uptodo/features/focus/presentation/widgets/focus_mode.dart';

class FocusModeScreen extends StatelessWidget {
  const FocusModeScreen({super.key});
  static const String routeName = "/focus";
  static const String name = "Focus";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(
        context: context,
        title: "Focus Mode",
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StopwatchTimer(),
            SizedBox(height: 20),
            AppUsageData(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
