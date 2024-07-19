import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/config/routes/router.dart';
import 'package:uptodo/config/theme/theme.dart';
import 'package:uptodo/core/services/injection_container.dart';
import 'package:uptodo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uptodo/features/auth/presentation/pages/auth_options_screen.dart';
import 'package:uptodo/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:uptodo/features/todo/presentation/pages/todo_screen.dart';
import 'package:uptodo/features/user/presentation/bloc/user_bloc.dart';

class UptodoApp extends StatelessWidget {
  const UptodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = sl.get<GoRouterProvider>().goRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => sl.get<AuthBloc>()),
        BlocProvider<UserBloc>(create: (context) => sl.get<UserBloc>()),
        BlocProvider<ThemeBloc>(create: (context) => sl.get<ThemeBloc>()..add(GetThemeModeEvent()))
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          log("AuthBloc State: $state");
          if (state is AuthInitial) router.go(AuthOptionsScreen.routeName);
          if (state is AuthLoginSuccess) {
            context.read<UserBloc>().add(GetUserEvent());
            router.go(TodoScreen.routeName);
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'UpTodo',
              debugShowCheckedModeBanner: false,
              theme: getThemeData(isDark: false),
              darkTheme: getThemeData(isDark: true),
              themeMode: state is ThemeLightState ? ThemeMode.light : ThemeMode.dark,
              routerConfig: router,
              builder: (context, child) {
                SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle(
                    systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
                    statusBarColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                );
                return child!;
              },
            );
          },
        ),
      ),
    );
  }
}
