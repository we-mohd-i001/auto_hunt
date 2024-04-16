import 'package:flutter/material.dart';

import '../../../vaahextendflutter/app_theme.dart';

class AppName extends StatelessWidget {
  final double size;
  const AppName({this.size = 10, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Auto.Hunt',
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: size * 2.2,
        color: AppTheme.colors['white'],
      ),
    );
  }
}
