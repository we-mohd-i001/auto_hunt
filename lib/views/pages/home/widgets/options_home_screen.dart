import 'package:flutter/material.dart';

import '../../../../helpers/commons.dart';
import '../../../../vaahextendflutter/app_theme.dart';

class OptionsHomeScreen extends StatelessWidget {
  final IconData icon;
  final String text;
  const OptionsHomeScreen({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 40,
          color: AppTheme.colors['white'],
        ),
        Text(text, style: normalWhite)
      ],
    );
  }
}
