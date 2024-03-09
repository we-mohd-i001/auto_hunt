import 'package:flutter/material.dart';

class ContinueWithEmailPage extends StatelessWidget {
  static const String routePath = '/with_email';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const ContinueWithEmailPage(),
    );
  }
  const ContinueWithEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Hero(
      tag: 'hero1',
      child: Scaffold(body: SafeArea(child: Column(

      )),),
    );
  }
}

