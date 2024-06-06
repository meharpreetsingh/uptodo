import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uptodo/features/auth/presentation/pages/auth_options_screen.dart';
import 'package:uptodo/features/auth/presentation/pages/login_screen.dart';
import 'package:uptodo/features/auth/presentation/pages/register_screen.dart';
import 'package:uptodo/features/focus/presentation/pages/focus_screen.dart';
import 'package:uptodo/features/general/presentation/pages/base_screen.dart';
import 'package:uptodo/features/general/presentation/pages/static/faq_screen.dart';
import 'package:uptodo/features/general/presentation/pages/static/help_screen.dart';
import 'package:uptodo/features/general/presentation/pages/static/privacy_security_screen.dart';
import 'package:uptodo/features/general/presentation/pages/static/support_screen.dart';
import 'package:uptodo/features/onboard/presentation/pages/onboard_page.dart';
import 'package:uptodo/features/general/presentation/pages/settings_screen.dart';
import 'package:uptodo/features/todo/domain/entity/todo.dart';
import 'package:uptodo/features/todo/presentation/pages/todo_archive_screen.dart';
import 'package:uptodo/features/todo/presentation/pages/todo_calender_screen.dart';
import 'package:uptodo/features/todo/presentation/pages/todo_create_screen.dart';
import 'package:uptodo/features/todo/presentation/pages/todo_details_screen.dart';
import 'package:uptodo/features/todo/presentation/pages/todo_screen.dart';
import 'package:uptodo/features/general/presentation/pages/profile_page.dart';
import 'package:uptodo/features/user/presentation/pages/account_screen.dart';

final GlobalKey<NavigatorState> _root = GlobalKey(debugLabel: "rootNav");
final GlobalKey<NavigatorState> _authShell =
    GlobalKey(debugLabel: "authShellNav");
final GlobalKey<NavigatorState> _baseShell =
    GlobalKey(debugLabel: "baseShellNav");

class GoRouterProvider {
  GoRouter goRouter() {
    return GoRouter(
      navigatorKey: _root,
      // initialLocation: TodoScreen.routeName, // Uncomment this line to test the TodoScreen
      redirect: (context, state) async {
        // First time App Opening
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final bool isOnboarded = prefs.getBool("isOnboarded") ?? false;
        if (!isOnboarded) return OnboardScreen.routeName;
        // User not logged in
        final User? user = FirebaseAuth.instance.currentUser;
        List<String> authRoutes = [
          LoginScreen.routeName,
          RegisterScreen.routeName,
          AuthOptionsScreen.routeName
        ];
        if (user == null &&
            !authRoutes.any((route) => state.fullPath!.contains(route))) {
          return AuthOptionsScreen.routeName;
        }

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
              pageBuilder: (context, state) =>
                  _transition(const AuthOptionsScreen()),
            ),
            GoRoute(
              path: LoginScreen.routeName,
              name: LoginScreen.name,
              pageBuilder: (context, state) => _transition(const LoginScreen()),
            ),
            GoRoute(
              path: RegisterScreen.routeName,
              name: RegisterScreen.name,
              pageBuilder: (context, state) =>
                  _transition(const RegisterScreen()),
            ),
          ],
        ),
        ShellRoute(
          navigatorKey: _baseShell,
          builder: (context, state, child) {
            return CommonMainScreen(child: child);
          },
          routes: [
            GoRoute(
              path: TodoScreen.routeName,
              name: TodoScreen.name,
              pageBuilder: (context, state) => _transition(const TodoScreen()),
            ),
            GoRoute(
              path: TodoDetailScreen.routeName,
              name: TodoDetailScreen.name,
              redirect: (context, state) {
                if (state.extra != null) return null;
                return TodoScreen.routeName;
              },
              pageBuilder: (context, state) =>
                  _transition(TodoDetailScreen(todo: state.extra as Todo)),
            ),
            GoRoute(
              path: TodoArchiveScreen.routeName,
              name: TodoArchiveScreen.name,
              pageBuilder: (context, state) =>
                  _transition(const TodoArchiveScreen()),
            ),
            GoRoute(
              path: TodoCreateScreen.routeName,
              name: TodoCreateScreen.name,
              pageBuilder: (context, state) =>
                  _transition(const TodoCreateScreen()),
            ),
            GoRoute(
              path: TodoCalenderScreen.routeName,
              name: TodoCalenderScreen.name,
              pageBuilder: (context, state) =>
                  _transition(const TodoCalenderScreen()),
            ),
            GoRoute(
              path: FocusModeScreen.routeName,
              name: FocusModeScreen.name,
              pageBuilder: (context, state) =>
                  _transition(const FocusModeScreen()),
            ),
            GoRoute(
              path: ProfileScreen.routeName,
              name: ProfileScreen.name,
              pageBuilder: (context, state) =>
                  _transition(const ProfileScreen()),
            ),
          ],
        ),
        GoRoute(
          path: AppSettingsScreen.routeName,
          name: AppSettingsScreen.name,
          pageBuilder: (context, state) =>
              _transition(const AppSettingsScreen()),
        ),
        GoRoute(
          path: AccountSettingScreen.routeName,
          name: AccountSettingScreen.name,
          pageBuilder: (context, state) =>
              _transition(const AccountSettingScreen()),
        ),
        GoRoute(
          path: FaqScreen.routeName,
          name: FaqScreen.name,
          pageBuilder: (context, state) => _transition(FaqScreen()),
        ),
        GoRoute(
          path: HelpScreen.routeName,
          name: HelpScreen.name,
          pageBuilder: (context, state) => _transition(const HelpScreen()),
        ),
        GoRoute(
          path: PrivacySecurityScreen.routeName,
          name: PrivacySecurityScreen.name,
          pageBuilder: (context, state) =>
              _transition(const PrivacySecurityScreen()),
        ),
        GoRoute(
          path: SupportUsScreen.routeName,
          name: SupportUsScreen.name,
          pageBuilder: (context, state) => _transition(const SupportUsScreen()),
        ),
      ],
    );
  }
}

_transition(Widget widget) {
  return CustomTransitionPage(
    child: widget,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}
