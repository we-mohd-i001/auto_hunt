import 'package:flutter/material.dart';

Widget iconWithText(icon, text) {
  return Row(
    children: [
      Icon(icon),
      const SizedBox(width: 8),
      Text(text),
    ],
  );
}
