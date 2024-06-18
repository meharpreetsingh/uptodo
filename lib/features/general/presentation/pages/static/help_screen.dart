import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  static const String routeName = "/help";
  static const String name = "Help";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(
        context: context,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset('assets/svg/icons/arrow-left.svg'),
        ),
        title: "Help & Support",
      ),
    );
  }
}
