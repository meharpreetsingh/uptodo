import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';

class StopwatchTimer extends StatefulWidget {
  const StopwatchTimer({super.key});

  @override
  State<StopwatchTimer> createState() => _StopwatchTimerState();
}

class _StopwatchTimerState extends State<StopwatchTimer> {
  final stopwatch = Stopwatch();
  bool isFocused = false;
  bool isDNDPermissionGranted = false;
  Timer? timer;
  String elapsedTime = "00:00";

  @override
  initState() {
    super.initState();
    checkDNDPermission().then((value) {
      setState(() => isDNDPermissionGranted = value);
      if (value == false) {
        timer = Timer.periodic(const Duration(seconds: 2), (timer) async {
          final bool permission = await checkDNDPermission();
          if (permission) {
            setState(() => isDNDPermissionGranted = true);
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }

  toggleFocusMode() async {
    if (!isFocused) {
      await turnOnFocusMode();
    } else {
      await turnOffFocusMode();
    }
  }

  turnOnFocusMode() async {
    await toggleDND(dnd: true);
    stopwatch.start();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (mounted) {
        setState(() {
          elapsedTime =
              '${stopwatch.elapsed.inMinutes.toString().padLeft(2, '0')}:${(stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
        });
      }
    });
    setState(() => isFocused = true);
  }

  turnOffFocusMode() async {
    await toggleDND(dnd: false);
    stopwatch.stop();
    stopwatch.reset();
    timer?.cancel();
    elapsedTime = "00:00";
    setState(() => isFocused = false);
  }

  Future<bool> checkDNDPermission() async {
    bool? isNotificationPolicyAccessGranted = await FlutterDnd.isNotificationPolicyAccessGranted;
    if (isNotificationPolicyAccessGranted == null || isNotificationPolicyAccessGranted == false) {
      return false;
    }
    return true;
  }

  toggleDND({bool dnd = false}) async {
    try {
      bool isNotificationPolicyAccessGranted = await checkDNDPermission();
      setState(() => isDNDPermissionGranted = isNotificationPolicyAccessGranted);
      if (isDNDPermissionGranted == false) return false;

      if (dnd == true) {
        await FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
      } else {
        await FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
      }
    } catch (e) {
      log("[toggleDND] $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isDNDPermissionGranted == false) {
      return TextButton(
        onPressed: () async {
          if (await checkDNDPermission()) {
            return setState(() => isDNDPermissionGranted = true);
          }
          FlutterDnd.gotoPolicySettings();
        },
        child: const Text("Grant DND Permissions to Start Focus Mode"),
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 7, color: Theme.of(context).colorScheme.surface),
            borderRadius: BorderRadius.circular(200),
          ),
          alignment: Alignment.center,
          height: 200,
          width: 200,
          child: Text(
            elapsedTime,
            style: const TextStyle(fontSize: 42),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "While your focus mode is on, all of your\nnotifications will be off.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6)),
          ),
        ),
        const SizedBox(height: 20),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(177, 0)),
          onPressed: () => toggleFocusMode(),
          child: Text("${!isFocused ? 'Start' : 'Stop'} Focusing"),
        )
      ],
    );
  }
}
