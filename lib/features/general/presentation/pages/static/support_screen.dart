import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:uptodo/common/widgets/global_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:store_redirect/store_redirect.dart';

class SupportUsScreen extends StatelessWidget {
  const SupportUsScreen({super.key});
  static const String routeName = "/support-us";
  static const String name = "Support Us";

  Future<void> _launchUrl({required String url}) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri)) throw Exception('Could not launch $uri');
    } catch (e) {
      log("[_launchUrl] Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(
        context: context,
        title: "Support Us",
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: SvgPicture.asset('assets/svg/icons/arrow-left.svg'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text(
              //   "If you like Uptodo, please consider supporting us by sharing the app with your friends and family.",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontSize: 16,
              //   ),
              // ),
              Text(
                "Credits",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                onTap: () {
                  _launchUrl(
                    url: "https://portfolio-mehar.vercel.app/",
                  );
                },
                leading: ClipOval(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      "assets/images/male_profile_icon.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: const Text(
                  "Meharpreet Singh",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Full Stack Developer"),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              ListTile(
                onTap: () {
                  // https://portfolio-mehar.vercel.app/
                  _launchUrl(
                    url: "https://www.linkedin.com/in/niharika-garg-15b9bb19b/",
                  );
                },
                leading: ClipOval(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset(
                      "assets/images/female_profile_icon.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: const Text(
                  "Niharika Garg",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("UI UX Designer"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Rate Uptodo",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 10),
              if (Platform.isAndroid)
                ListTile(
                  onTap: () {
                    try {
                      String appId = "com.devbymehar.UpTodo";
                      // _launchUrl(url: "market://details?id=$appId");
                      // TODO Make this work for iOS & Android
                      StoreRedirect.redirect(androidAppId: appId, iOSAppId: appId);
                    } catch (e) {
                      log("[SupportUsScreen] Error: $e");
                    }
                  },
                  leading: SvgPicture.asset(
                    'assets/svg/icons/play.svg',
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  title: const Text("Google Play Store"),
                )
            ],
          ),
        ),
      ),
    );
  }
}
