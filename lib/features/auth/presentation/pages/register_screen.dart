import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/features/auth/presentation/pages/login_screen.dart';
import 'package:uptodo/features/auth/presentation/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  static String name = "Register";
  static String routeName = "/register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Register",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.87),
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 40),
              const RegisterForm(),
              const SizedBox(height: 20),
              const Row(
                children: [Expanded(child: Divider(endIndent: 10)), Text("or"), Expanded(child: Divider(indent: 10))],
              ),
              const SizedBox(height: 20),
              if (Platform.isAndroid || kIsWeb)
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/svg/icons/google_g_logo.svg",
                    fit: BoxFit.contain,
                    height: 24,
                    width: 24,
                  ),
                  label: const Text("Sign up with Google"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      context.replace(LoginScreen.routeName);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text("Login"),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
