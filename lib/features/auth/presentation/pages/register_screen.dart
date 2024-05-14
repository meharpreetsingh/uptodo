import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/features/auth/presentation/pages/login_screen.dart';

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
            // TODO Implement this
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
                      // TODO Implement this
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

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(text: "");
  final TextEditingController _userNameController = TextEditingController(text: "");
  final TextEditingController _passwordController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }

  _submitRegisterHandler() {}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Username",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: _userNameController,
            decoration: const InputDecoration(hintText: "Enter your Username"),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Username can't be empty";
              }
              if (value.length < 5 || value.length > 22) {
                return "Username length must be between 6 and 21";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text("Email Address",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              )),
          const SizedBox(height: 5),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Enter your email"),
            validator: (value) {
              // TODO Implement this
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text("Password", style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
          const SizedBox(height: 5),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Password"),
            validator: (value) {
              //   TODO Implement this
              return null;
            },
          ),
          const SizedBox(height: 20),
          Text(
            "Confirm Password",
            style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
          ),
          const SizedBox(height: 5),
          TextFormField(
            obscureText: false,
            decoration: const InputDecoration(hintText: "Password"),
            validator: (String? value) {
              if (value != _passwordController.value.text) {
                return "Passwords don't match";
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          FilledButton(
            onPressed: _submitRegisterHandler,
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
