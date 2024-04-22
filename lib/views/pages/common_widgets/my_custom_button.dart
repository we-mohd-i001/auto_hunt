import 'package:flutter/material.dart';

import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';

class MyCustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String tag;
  final String? text;
  final ButtonType type;
  const MyCustomButton(
      {super.key,
      this.onPressed,
      required this.tag,
      this.text,
      required this.type});

  @override
  Widget build(BuildContext context) {
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
}
