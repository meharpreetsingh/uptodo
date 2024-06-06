import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:uptodo/features/auth/presentation/pages/auth_options_screen.dart';

class OnboardScreen extends StatefulWidget {
  static const String name = "Onboard";
  static const String routeName = "/onboard";
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final _onboardKey = GlobalKey<_OnboardScreenState>();

  _pageViewGenerator({required String title, required String body, required Widget image}) {
    return PageViewModel(
      decoration: const PageDecoration(
        bodyAlignment: Alignment.center,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
      ),
      image: Container(
        margin: const EdgeInsets.only(top: 30),
        child: image,
      ),
      title: title,
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        key: _onboardKey,
        safeAreaList: const [true, true, true, true],
        showNextButton: true,
        nextFlex: 0,
        showSkipButton: true,
        skipOrBackFlex: 0,
        skip: const Text("SKIP"),
        done: const Text("LOGIN"),
        next: const Text("NEXT"),
        globalHeader: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "/devbymehar",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ),
        nextStyle: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        skipStyle: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          foregroundColor: Colors.grey,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        doneStyle: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        onDone: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("isOnboarded", true);
          // TODO Change SharedPreferences ("isOnboarded")
          if (mounted) context.go(AuthOptionsScreen.routeName);
          // TODO Redirect to AuthScreen
        },
        pages: [
          _pageViewGenerator(
            image: SvgPicture.asset("assets/svg/manage_tasks.svg"),
            title: "Manage your tasks",
            body: "You can easily manage all of your daily tasks in\nUpTodo for free",
          ),
          _pageViewGenerator(
            image: SvgPicture.asset("assets/svg/calender_view.svg"),
            title: "Create daily routine",
            body: "In Uptodo, you can create your\npersonalized routine to stay productive",
          ),
          _pageViewGenerator(
            image: SvgPicture.asset("assets/svg/organize_tasks.svg"),
            title: "Organize your tasks",
            body: "You can organize your daily tasks by\nadding your tasks into separate categories",
          ),
        ],
      ),
    );
  }
}
