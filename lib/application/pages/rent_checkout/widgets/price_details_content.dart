import 'package:flutter/material.dart';

Widget priceDetailContent(String title, String content) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title),
      Text(content),
    ],
  );
}