import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/constants.dart';

Widget iconWithText(icon, text, onPressed) {
  return MaterialButton(
    onPressed: onPressed,
    child: Row(
      children: [
        Icon(icon),
        horizontalMargin8,
        Text(text),
      ],
    ),
  );
}
