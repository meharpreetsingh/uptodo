import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

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
            onPressed: () {},
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
            onPressed: () {},
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
