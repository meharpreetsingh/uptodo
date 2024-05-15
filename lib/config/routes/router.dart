import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uptodo/features/auth/presentation/pages/auth_options_screen.dart';
import 'package:uptodo/features/auth/presentation/pages/login_screen.dart';
import 'package:uptodo/features/auth/presentation/pages/register_screen.dart';
import 'package:uptodo/features/onboard/presentation/pages/onboard_page.dart';

final GlobalKey<NavigatorState> _root = GlobalKey(debugLabel: "rootNav");
final GlobalKey<NavigatorState> _authShell = GlobalKey(debugLabel: "authShellNav");
final GlobalKey<NavigatorState> _shell = GlobalKey(debugLabel: "shellNav");

class GoRouterProvider {
  GoRouter goRouter() {
    return GoRouter(
      navigatorKey: _root,
      initialLocation: "/",
      redirect: (context, state) async {
        // Onboard Screen if App is Opening the First time
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final bool isOnboarded = prefs.getBool("isOnboarded") ?? false;
        if (!isOnboarded) return OnboardScreen.routeName;

        // Authentication Screen if User not logged in
        final User? user = FirebaseAuth.instance.currentUser;
        List<String> authRoutes = [LoginScreen.routeName, RegisterScreen.routeName, AuthOptionsScreen.routeName];
        if (user == null && !authRoutes.any((route) => state.fullPath!.contains(route))) return AuthOptionsScreen.routeName;

        return null;
      },
      routes: [
        GoRoute(
          path: OnboardScreen.routeName,
          name: OnboardScreen.name,
          pageBuilder: (context, state) => _transition(const OnboardScreen()),
        ),
        ShellRoute(
          navigatorKey: _authShell,
          builder: (context, state, child) {
            return child;
          },
          routes: [
            GoRoute(
              path: AuthOptionsScreen.routeName,
              name: AuthOptionsScreen.name,
              pageBuilder: (context, state) => _transition(const AuthOptionsScreen()),
            ),
            GoRoute(
              path: LoginScreen.routeName,
              name: LoginScreen.name,
              pageBuilder: (context, state) => _transition(const LoginScreen()),
            ),
            GoRoute(
              path: RegisterScreen.routeName,
              name: RegisterScreen.name,
              pageBuilder: (context, state) => _transition(const RegisterScreen()),
            ),
          ],
        ),
      ],
    );
  }
}

_transition(Widget widget) {
  return CustomTransitionPage(
    child: widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}
