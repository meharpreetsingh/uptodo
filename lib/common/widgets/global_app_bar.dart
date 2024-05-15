import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uptodo/features/user/presentation/bloc/user_bloc.dart';

AppBar globalAppBar({
  required BuildContext context,
  required String title,
  bool? showProfileIcon,
  List<Widget>? actions,
  Widget? leading,
}) {
  return AppBar(
    leading: leading,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    centerTitle: true,
    title: Text(
      title,
      style: const TextStyle(fontSize: 20),
    ),
    actions: actions != null
        ? [
            ...actions,
            if (showProfileIcon != null && showProfileIcon) const ProfileIcon(),
            const SizedBox(width: 20),
          ]
        : [
            if (showProfileIcon != null && showProfileIcon) const ProfileIcon(),
            const SizedBox(width: 20),
          ],
  );
}

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = context.read<UserBloc>();
    if (userBloc.state is UserInitial) userBloc.add(GetUserEvent());
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const SizedBox(height: 32, width: 32, child: CircularProgressIndicator(strokeWidth: 1));
        }
        return IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            userBloc.add(GetUserEvent());
          },
        );
      },
    );
  }
}
