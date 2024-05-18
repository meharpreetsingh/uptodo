import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/features/user/presentation/widgets/profile_pic_icon.dart';

AppBar globalAppBar({
  required BuildContext context,
  String? title,
  bool? showProfileIcon,
  List<Widget>? actions,
  Widget? leading,
  bool showBackButton = false,
}) {
  Widget backButton() {
    return IconButton(
      icon: SvgPicture.asset(
        "assets/svg/icons/arrow-left.svg",
        color: Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: () {
        context.pop();
      },
    );
  }

  return AppBar(
    leading: leading ?? (showBackButton ? backButton() : null),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    centerTitle: true,
    title: title != null
        ? Text(
            title,
            style: const TextStyle(fontSize: 20),
          )
        : null,
    actions: [
      if (actions != null) ...actions,
      if (showProfileIcon != null && showProfileIcon) const ProfileIcon(),
      const SizedBox(width: 24),
    ],
  );
}
