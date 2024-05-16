import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/config/routes/router.dart';
import 'package:uptodo/config/theme/theme.dart';
import 'package:uptodo/core/services/injection_container.dart';
import 'package:uptodo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uptodo/features/auth/presentation/pages/auth_options_screen.dart';
import 'package:uptodo/features/user/presentation/bloc/user_bloc.dart';

class UptodoApp extends StatelessWidget {
  const UptodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = sl.get<GoRouterProvider>().goRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => sl.get<AuthBloc>()),
        BlocProvider<UserBloc>(create: (context) => sl.get<UserBloc>())
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) router.go(AuthOptionsScreen.routeName);
        },
        child: MaterialApp.router(
          title: 'TODO',
          debugShowCheckedModeBanner: false,
          theme: getThemeData(isDark: false),
          darkTheme: getThemeData(isDark: true),
          themeMode: ThemeMode.dark,
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
        ),
      ),
    );
  }
}
