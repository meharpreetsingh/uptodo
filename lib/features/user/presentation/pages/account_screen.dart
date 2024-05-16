import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';
import 'package:uptodo/features/user/presentation/bloc/user_bloc.dart';
import 'package:uptodo/features/user/presentation/widgets/update_username_dialog.dart';
import 'package:image_picker/image_picker.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});
  static const String routeName = "/account-setting";
  static const String name = "Account Setting";

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial || state is UserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserError) {
          return const Center(
            child: Text("Error Loading User Data"),
          );
        }
        if (state is UserFound) {
          return Scaffold(
            appBar: globalAppBar(
              context: context,
              title: "Account Management",
              leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: SvgPicture.asset(
                  "assets/svg/icons/arrow-left.svg",
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipOval(
                          child: SizedBox(
                            height: 130,
                            width: 130,
                            child: state.user.photoUrl != null
                                ? Image.network(
                                    state.user.photoUrl!,
                                    color: Colors.white24,
                                    colorBlendMode: BlendMode.xor,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/images/male_profile_icon.jpg",
                                    color: Colors.white24,
                                    colorBlendMode: BlendMode.xor,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                if (image == null) return;
                                userBloc.add(UpdatePhotoUrlEvent(state.user, image.path));
                              },
                              icon: SvgPicture.asset(
                                "assets/svg/icons/edit.svg",
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    //   Profile Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.user.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () async {
                            final name = await showDialog<String>(
                              context: context,
                              builder: (_) => UpdateUsernameDialog(initialValue: state.user.name),
                            );
                            if (name != null) userBloc.add(UpdateUserEvent(state.user.copyWith(name: name)));
                          },
                          icon: SvgPicture.asset(
                            "assets/svg/icons/edit-2.svg",
                            color: Theme.of(context).colorScheme.onSurface,
                            height: 20,
                            width: 20,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/svg/icons/calendar.svg",
                        height: 24,
                        width: 24,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      title: const Text("Date of Birth"),
                      trailing: Text(
                        state.user.dob != null ? DateFormat("yyyy-MM-dd").format(state.user.dob!) : "Not Set",
                        style: const TextStyle(fontSize: 16),
                      ),
                      onTap: () async {
                        final DateTime? dob = await showDatePicker(
                          context: context,
                          initialDate: state.user.dob ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (dob != null) {
                          userBloc.add(UpdateUserEvent(state.user.copyWith(dob: dob)));
                        }
                      },
                    ),

                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/svg/icons/grammerly.svg",
                        height: 24,
                        width: 24,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      title: const Text("Gender"),
                      trailing: DropdownButton<String>(
                        value: state.user.gender,
                        onChanged: (String? value) {
                          userBloc.add(UpdateUserEvent(state.user.copyWith(gender: value)));
                        },
                        items: ["Male", "Female", "Other"]
                            .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(
                                value: e.toLowerCase(),
                                child: Text(e),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Id - ${state.user.uid}",
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
