import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/util/validators.dart';
import 'package:uptodo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uptodo/features/home/presentation/pages/home_screen.dart';

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

  late AuthBloc auth;

  @override
  void initState() {
    auth = context.read<AuthBloc>();
    super.initState();
  }

  _submitRegisterHandler() {
    if (!_formKey.currentState!.validate()) return;
    auth.add(AuthRegisterEvent(
      name: _userNameController.value.text,
      emailId: _emailController.value.text,
      password: _passwordController.value.text,
      createdAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccess) context.go(HomeScreen.routeName);
      },
      builder: (context, state) {
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
                validator: validateUsername,
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
                validator: validateEmail,
              ),
              const SizedBox(height: 20),
              Text("Password", style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7))),
              const SizedBox(height: 5),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "Password"),
                validator: validatePassword,
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
                  if (value != _passwordController.value.text) return "Passwords don't match";
                  return null;
                },
              ),
              if (state is AuthRegisterError) ...[
                const SizedBox(height: 10),
                Text(
                  state.message,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 30),
              (state is AuthRegisterLoading)
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton(
                      onPressed: _submitRegisterHandler,
                      child: const Text("Register"),
                    ),
            ],
          ),
        );
      },
    );
  }
}
