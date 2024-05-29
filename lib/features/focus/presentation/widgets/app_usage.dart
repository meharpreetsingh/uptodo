import 'dart:typed_data';

import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:device_apps/device_apps.dart';

class AppUsageData extends StatefulWidget {
  const AppUsageData({super.key});

  @override
  State<AppUsageData> createState() => _AppUsageDataState();
}

class _AppUsageDataState extends State<AppUsageData> {
  late DateTime startDate;
  late DateTime endDate;
  List<AppUsageInfo>? appUsageInfoList;
  AppUsage appUsage = AppUsage();
  List<Application>? apps;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    endDate = DateTime.now();
    getAppUsage(startDate: startDate, endDate: endDate);
    getApps();
  }

  getApps() async {
    apps = await DeviceApps.getInstalledApplications(includeAppIcons: true, includeSystemApps: true);
    setState(() => isLoading = false);
  }

  getAppUsage({required DateTime startDate, required DateTime endDate}) async {
    setState(() => isLoading = true);
    appUsageInfoList = await appUsage.getAppUsage(startDate, endDate);
    setState(() => isLoading = false);
  }

  onDurationChange(value) {
    switch (value) {
      case 'Today':
        startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
        endDate = DateTime.now();
        break;
      case 'Yesterday':
        startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);
        endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1, 23, 59, 59);
        break;
      case 'Last 7 Days':
        startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 6);
        endDate = DateTime.now();
        break;
      case 'Last 30 Days':
        startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 29);
        endDate = DateTime.now();
        break;
    }
    getAppUsage(startDate: startDate, endDate: endDate);
  }

  /// Get App Icon from package name
  ApplicationWithIcon? getAppFromPackageName(String packageName) {
    try {
      if (apps == null) return null;
      Application? targetApp = apps!.firstWhere((app) => app.packageName == packageName);
      if (targetApp is ApplicationWithIcon) return targetApp;
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (appUsageInfoList == null || isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Overview",
                style: TextStyle(fontSize: 20),
              ),
              DropdownMenu(
                width: 150,
                textStyle: const TextStyle(fontSize: 12),
                initialSelection: 'Today',
                inputDecorationTheme: InputDecorationTheme(
                    fillColor: Theme.of(context).colorScheme.surface,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    )),
                trailingIcon: SvgPicture.asset(
                  "assets/svg/icons/arrow-down.svg",
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                selectedTrailingIcon: SvgPicture.asset(
                  "assets/svg/icons/arrow-up.svg",
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                dropdownMenuEntries: <DropdownMenuEntry>[
                  ...[
                    'Today',
                    'Yesterday',
                    'Last 7 Days',
                    'Last 30 Days',
                  ].map((e) => DropdownMenuEntry(label: e, value: e))
                ],
                onSelected: (value) => onDurationChange(value),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (appUsageInfoList != null)
          ListView.builder(
            // separatorBuilder: (context, index) => const SizedBox(height: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: appUsageInfoList!.length,
            itemBuilder: (context, index) {
              AppUsageInfo usage = appUsageInfoList![index];
              final String usageTime = "${usage.usage.inMinutes ~/ 60} hours ${usage.usage.inMinutes % 60} minutes";
              ApplicationWithIcon? app = getAppFromPackageName(usage.packageName);
              if (app != null && app.systemApp) return Container();
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: app != null
                      ? Image.memory(app.icon)
                      : SvgPicture.asset(
                          "assets/svg/icons/android.svg",
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  title: Text(usage.appName),
                  subtitle: Text("Usage: $usageTime"),
                ),
              );
            },
          ),
      ],
    );
  }
}
