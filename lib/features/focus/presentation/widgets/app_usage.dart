import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppUsageData extends StatefulWidget {
  const AppUsageData({super.key});

  @override
  State<AppUsageData> createState() => _AppUsageDataState();
}

class _AppUsageDataState extends State<AppUsageData> {
  late DateTime startDate;
  late DateTime endDate;
  List<AppUsageInfo>? appUsageInfoList;

  @override
  void initState() {
    super.initState();
    // startDate from starting of today at 00:00:00
    startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    // endDate to current time
    endDate = DateTime.now();
    getAppUsage();
  }

  getAppUsage() async {
    AppUsage appUsage = AppUsage();
    appUsageInfoList = await appUsage.getAppUsage(startDate, endDate);
    appUsageInfoList!.forEach((element) {
      print("App: ${element.appName}, Time: ${element.usage}");
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (appUsageInfoList == null) {
      return Center(child: const CircularProgressIndicator());
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
