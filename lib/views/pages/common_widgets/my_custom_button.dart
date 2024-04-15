import 'package:flutter/material.dart';

import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';

Widget myCustomButton({
  void Function()? onPressed,
  required String tag,
  String? text,
  required ButtonType type,
}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: Hero(
          tag: tag,
          child: ButtonElevated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            onPressed: onPressed,
            text: text ?? 'Press',
            buttonType: type,
            fontSize: 17,
            borderRadius: 8,
            foregroundColor: AppTheme.colors['white'],
          ),
        ),
      ),
    ),
  );
}
