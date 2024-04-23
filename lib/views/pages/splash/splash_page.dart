import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/splash/splash_controller.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../common_widgets/logo_with_name.dart';

class SplashPage extends StatelessWidget {
  static const String routePath = '/';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const SplashPage(),
    );
  }

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppTheme.colors['black'],
      body: const Center(
        child: SizedBox(
            child: LogoWithName(
          mainAxisAlignment: MainAxisAlignment.center,
          size: 16,
        )),
      ),
    );
  }
}
