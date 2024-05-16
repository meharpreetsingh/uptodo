import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';
import 'package:uptodo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uptodo/features/general/presentation/pages/settings_screen.dart';
import 'package:uptodo/features/user/presentation/bloc/user_bloc.dart';
import 'package:uptodo/features/user/presentation/pages/account_screen.dart';

class ProfileScreen extends StatelessWidget {
  static const String name = 'Profile';
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

  buildProfileDetails() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading || state is UserInitial) {}
        if (state is UserError) {}
        if (state is UserFound) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 75,
                child: ClipOval(
                  child: state.user.photoUrl != null
                      ? Image.network(
                          state.user.photoUrl!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/male_profile_icon.jpg",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                state.user.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: globalAppBar(context: context, title: "Profile"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildProfileDetails(),
                const SizedBox(height: 30),
                Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/svg/icons/setting-2.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: const Text("App Settings"),
                  trailing: SvgPicture.asset(
                    "assets/svg/icons/arrow-right.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onTap: () {
                    context.push(AppSettingsScreen.routeName);
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/svg/icons/user.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: const Text("Account"),
                  trailing: SvgPicture.asset(
                    "assets/svg/icons/arrow-right.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onTap: () {
                    context.push(AccountSettingScreen.routeName);
                  },
                ),
                const SizedBox(height: 5),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/svg/icons/security-user.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: const Text("Privacy & Security"),
                  trailing: SvgPicture.asset(
                    "assets/svg/icons/arrow-right.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 10),
                Text(
                  "UpTodo",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/svg/icons/menu.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: const Text("About Us"),
                  trailing: SvgPicture.asset(
                    "assets/svg/icons/arrow-right.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 5),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/svg/icons/info-circle.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: const Text("FAQs"),
                  trailing: SvgPicture.asset(
                    "assets/svg/icons/arrow-right.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 5),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/svg/icons/flash.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: const Text("Help & Feedback"),
                  trailing: SvgPicture.asset(
                    "assets/svg/icons/arrow-right.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 5),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/svg/icons/like.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: const Text("Support Us"),
                  trailing: SvgPicture.asset(
                    "assets/svg/icons/arrow-right.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/svg/icons/logout.svg",
                    height: 24,
                    width: 24,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  onTap: () {
                    context.read<AuthBloc>().add(AuthLogoutEvent());
                    // context.go(AuthOptionsScreen.routeName);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ));
  }
}
