import 'package:flutter/material.dart';

import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';

class LoginPage extends StatelessWidget {
  static const String routePath = '/login';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const LoginPage(),
    );
  }

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/login_page_background.jpg',
                      ),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/auto_hunt_logo.png'),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Auto.Hunt',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                            color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '''Let's get started''',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 34,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Sign up or login to see what',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white70),
                  ),
                  const Text(
                    'happening near you',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Colors.white70),
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonElevated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      onPressed: () {},
                      text: "Continue with Email",
                      fontSize: 17,
                      buttonType: ButtonType.white,
                      foregroundColor: Colors.black,
                      borderRadius: 8,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonOutlinedWithIcon(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      fontSize: 17,
                      onPressed: () {},
                      foregroundColor: Colors.white,
                      text: "Continue with Facebook",
                      buttonType: ButtonType.secondary,
                      borderRadius: 8,
                      iconData: Icons.facebook,
                      iconSize: 19,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonOutlinedWithIcon(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      fontSize: 17,
                      onPressed: () {},
                      foregroundColor: Colors.white,
                      text: "Continue with Apple",
                      buttonType: ButtonType.secondary,
                      borderRadius: 8,
                      iconData: Icons.apple,
                      iconSize: 19,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
