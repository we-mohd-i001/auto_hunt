import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/constants.dart';

Widget priceDetailContent(String title, String content) {
  return Padding(
    padding: horizontalPadding12,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(content),
      ],
    ),
  );
}