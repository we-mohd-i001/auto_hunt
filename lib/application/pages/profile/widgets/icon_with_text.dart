import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/constants.dart';

Widget iconWithText(icon, text) {
  return Row(
    children: [
      Icon(icon),
      verticalMargin8,
      Text(text),
    ],
  );
}
