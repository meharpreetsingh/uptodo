import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/core/util/validators.dart';
import 'package:uptodo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uptodo/features/home/presentation/pages/home_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController(text: "");
  final TextEditingController _passwordController = TextEditingController(text: "");
  late AuthBloc auth;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  initState() {
    super.initState();
    auth = context.read<AuthBloc>();
  }

  _submitLoginFormHandler() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    auth.add(AuthLoginEvent(emailId: _emailController.value.text, password: _passwordController.value.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccess) context.go(HomeScreen.routeName);
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Email Address",
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: "Enter your email"),
                validator: validateEmail,
              ),
              const SizedBox(height: 20),
              Text(
                "Password",
                style: TextStyle(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7)),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "Password"),
                validator: validatePassword,
              ),
              if (state is AuthLoginError) ...[
                const SizedBox(height: 10),
                Text(
                  state.message,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 30),
              (state is AuthLoginLoading)
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton(
                      onPressed: _submitLoginFormHandler,
                      child: const Text("Login"),
                    ),
            ],
          ),
        );
      },
    );
  }
}
