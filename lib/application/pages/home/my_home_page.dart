import 'package:flutter/material.dart';
import 'package:yourtasks/application/pages/login/login_page.dart';

import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';

class MyHomePage extends StatelessWidget {
  static const String routePath = '/home';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const MyHomePage(),
    );
  }
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonElevated(
      onPressed: () {
        Navigator.pushNamed(context, LoginPage.routePath);
      },
      text: "Info",
      buttonType: ButtonType.info,
    );
  }
}
