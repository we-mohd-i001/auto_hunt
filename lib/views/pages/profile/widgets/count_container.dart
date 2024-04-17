import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/app_theme.dart';
import '../../../../helpers/commons.dart';

Widget countContainer(count, type) {
  return Container(
    height: 80,
    width: 160,
    decoration: BoxDecoration(
      color: AppTheme.colors['white'],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            count,
            style: subheadingBlack,
          ),
          Text(
            type,
            style: normalBlack,
          )
        ],
      ),
    ),
  );
}
