
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../vaahextendflutter/app_theme.dart';

Widget learnMoreWithTitle(title, {String changeLearnMore = Strings.learnMore}){
  return Padding(
    padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          changeLearnMore,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: AppTheme.colors['secondary']),
        )
      ],
    ),
  );
}