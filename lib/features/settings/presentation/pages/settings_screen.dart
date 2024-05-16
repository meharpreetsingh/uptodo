import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';
import 'package:uptodo/features/theme/presentation/bloc/theme_bloc.dart';

class AppSettingsScreen extends StatefulWidget {
  static const String name = "Settings";
  static const String routeName = "/settings";
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  late ThemeBloc themeBloc;
  _changeThemeMode() {
    if (themeBloc.state is ThemeLightState) {
      themeBloc.add(ToggleDarkModeEvent());
    } else if (themeBloc.state is ThemeDarkState) {
      themeBloc.add(ToggleLightModeEvent());
    }
  }

  @override
  void initState() {
    themeBloc = context.read<ThemeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(
        context: context,
        title: "Settings",
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(
            "assets/svg/icons/arrow-left.svg",
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Settings",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/svg/icons/brush.svg",
                  height: 24,
                  width: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                title: const Text("Change app color"),
                trailing: Switch(
                  value: (context.watch<ThemeBloc>().state is! ThemeLightState),
                  onChanged: (bool value) => _changeThemeMode(),
                ),
              ),
              const SizedBox(height: 5),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/svg/icons/text.svg",
                  height: 24,
                  width: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                title: const Text("Change app typography"),
                trailing: SvgPicture.asset(
                  "assets/svg/icons/arrow-right.svg",
                  height: 24,
                  width: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onTap: () {},
              ),
              const SizedBox(height: 5),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/svg/icons/language-square.svg",
                  height: 24,
                  width: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                title: const Text("Change app language"),
                trailing: SvgPicture.asset(
                  "assets/svg/icons/arrow-right.svg",
                  height: 24,
                  width: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onTap: () {},
              ),
              const SizedBox(height: 10),
              Text(
                "Import",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/svg/icons/import.svg",
                  height: 24,
                  width: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                title: const Text("Import from Google calendar"),
                trailing: SvgPicture.asset(
                  "assets/svg/icons/arrow-right.svg",
                  height: 24,
                  width: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
