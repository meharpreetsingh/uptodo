import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/features/auth/presentation/pages/register_screen.dart';
import 'package:uptodo/features/auth/presentation/widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String name = "Login";
  static String routeName = "/login";

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
                "Login",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.87),
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 40),
              const LoginForm(),
              const SizedBox(height: 20),
              // const Row(
              //   children: [Expanded(child: Divider(endIndent: 10)), Text("or"), Expanded(child: Divider(indent: 10))],
              // ),
              // const SizedBox(height: 20),
              // if (Platform.isAndroid || kIsWeb)
              //   OutlinedButton.icon(
              //     onPressed: () {
              //       context.read<AuthBloc>().add(AuthGoogleSignInEvent());
              //     },
              //     icon: SvgPicture.asset(
              //       "assets/svg/icons/google_g_logo.svg",
              //       fit: BoxFit.contain,
              //       height: 24,
              //       width: 24,
              //     ),
              //     label: const Text("Login with Google"),
              //     style: OutlinedButton.styleFrom(
              //       foregroundColor: Theme.of(context).colorScheme.onSurface,
              //     ),
              //   ),
              // const SizedBox(height: 10),
              // // TODO Setup Apple Sign In
              // if (Platform.isIOS || kIsWeb)
              //   OutlinedButton.icon(
              //     onPressed: () {},
              //     icon: SvgPicture.asset(
              //       "assets/svg/icons/apple-svg.svg",
              //       color: Theme.of(context).colorScheme.onSurface,
              //       fit: BoxFit.contain,
              //       height: 24,
              //       width: 24,
              //     ),
              //     label: const Text("Login with Apple"),
              //     style: OutlinedButton.styleFrom(
              //       foregroundColor: Theme.of(context).colorScheme.onSurface,
              //     ),
              //   ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account?"),
                  TextButton(
                    onPressed: () {
                      context.replace(RegisterScreen.routeName);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text("Register"),
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
