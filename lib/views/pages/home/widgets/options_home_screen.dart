import 'package:flutter/material.dart';

import '../../../../helpers/commons.dart';
import '../../../../vaahextendflutter/app_theme.dart';

Widget optionsHomeScreen(icon, text) {
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
