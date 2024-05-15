import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/features/auth/presentation/pages/login_screen.dart';
import 'package:uptodo/features/auth/presentation/pages/register_screen.dart';

class AuthOptionsScreen extends StatefulWidget {
  static String name = "AuthOptions";
  static String routeName = "/auth";
  const AuthOptionsScreen({super.key});

  @override
  State<AuthOptionsScreen> createState() => _AuthOptionsScreenState();
}

class _AuthOptionsScreenState extends State<AuthOptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(flex: 1, child: Container()),
            SvgPicture.asset(
              "assets/svg/manage_tasks.svg",
              height: 200,
              fit: BoxFit.contain,
            ),
            Text(
              "Welcome to UpTodo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.87),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Please login to your account or create\nnew account to continue",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.67),
              ),
            ),
            Expanded(flex: 2, child: Container()),
            FilledButton(
              onPressed: () {
                context.push(LoginScreen.routeName);
              },
              child: const Text("LOGIN"),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                context.push(RegisterScreen.routeName);
              },
              child: const Text("CREATE ACCOUNT"),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
