import 'package:flutter/material.dart';

Widget optionsHomeScreen(icon, text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: 40,
        color: Colors.white,
      ),
      Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      )
    ],
  );
}