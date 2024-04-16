import 'package:flutter/material.dart';

class LogoIcon extends StatelessWidget {
  final double size;
  const LogoIcon({
    this.size = 10.0,
    super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size*2,
      backgroundImage:
      const AssetImage('assets/images/auto_hunt_logo.png'),
    );
  }
}
