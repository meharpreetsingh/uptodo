import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/features/todo/presentation/pages/todo_screen.dart';
import 'package:uptodo/features/user/presentation/pages/profile_page.dart';

class MainBottomAppBar extends StatelessWidget {
  const MainBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 10,
      color: Theme.of(context).colorScheme.background,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              context.go(TodoScreen.routeName);
            },
            icon: SvgPicture.asset(
              "assets/svg/icons/home-2.svg",
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/svg/icons/calendar.svg",
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/svg/icons/clock.svg",
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          IconButton(
            onPressed: () {
              context.go(ProfileScreen.routeName);
            },
            icon: SvgPicture.asset(
              "assets/svg/icons/user.svg",
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
