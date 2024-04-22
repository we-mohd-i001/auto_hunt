import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../helpers/commons.dart';

class IconWithText extends StatelessWidget {
  final IconData? icon;
  final String text;
  final void Function()? onPressed;
  const IconWithText(
      {super.key, this.icon, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            icon,
          ),
          horizontalMargin8,
          Text(
            text,
            style: subheadingBlack,
          ),
        ],
      ),
    );
  }
}
