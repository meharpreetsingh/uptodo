import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/config/routes/router.dart';
import 'package:uptodo/config/theme/theme.dart';
import 'package:uptodo/core/services/injection_container.dart';
import 'package:uptodo/features/auth/presentation/bloc/auth_bloc.dart';

class UptodoApp extends StatelessWidget {
  const UptodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = sl.get<GoRouterProvider>();

    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: MaterialApp.router(
        title: 'TODO',
        debugShowCheckedModeBanner: false,
        theme: getThemeData(isDark: false),
        darkTheme: getThemeData(isDark: true),
        themeMode: ThemeMode.dark,
        routerConfig: router.goRouter(),
        builder: (context, child) {
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
              statusBarColor: Theme.of(context).scaffoldBackgroundColor,
            ),
          );
          return child!;
        },
      ),
    );
  }
}