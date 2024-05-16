import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/features/user/presentation/bloc/user_bloc.dart';
import 'package:uptodo/features/user/presentation/pages/profile_page.dart';

class ProfileIcon extends StatefulWidget {
  const ProfileIcon({super.key});

  @override
  State<ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
    if (userBloc.state is UserInitial) userBloc.add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading || state is UserInitial) {
          return const SizedBox(height: 32, width: 32, child: CircularProgressIndicator(strokeWidth: 2));
        }
        if (state is UserError) {
          return const Icon(Icons.error);
        }
        if (state is UserFound) {
          return GestureDetector(
            onTap: () {
              context.go(ProfileScreen.routeName);
            },
            child: CircleAvatar(
              radius: 21,
              child: ClipOval(
                child: state.user.photoUrl != null
                    ? Image.network(state.user.photoUrl!)
                    : Image.asset("assets/images/female_profile_icon.jpeg"),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
