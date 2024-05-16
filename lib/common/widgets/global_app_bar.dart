import 'package:flutter/material.dart';
import 'package:uptodo/common/widgets/profile_pic_icon.dart';

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
    actions: [
      if (actions != null) ...actions,
      if (showProfileIcon != null && showProfileIcon) const ProfileIcon(),
      const SizedBox(width: 24),
    ],
  );
}
