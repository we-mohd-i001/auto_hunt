import 'package:flutter/material.dart';

import '../../../../constants/strings/strings.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import 'options_home_screen.dart';

Widget homeScreenOptions() {
  return Container(
    alignment: Alignment.bottomLeft,
    width: double.infinity,
    color: AppTheme.colors['primary'],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
            flex: 0,
            child:
            optionsHomeScreen(Icons.car_rental_rounded, Strings.rentCar)),
        const VerticalDivider(
          color: Colors.grey,
          indent: 10,
          thickness: 1,
          endIndent: 10,
        ),
        Expanded(
            flex: 0,
            child: optionsHomeScreen(Icons.car_repair_rounded, Strings.buyCar)),
        const VerticalDivider(
          color: Colors.grey,
          indent: 10,
          thickness: 1,
          endIndent: 10,
        ),
        Expanded(
            flex: 0,
            child: optionsHomeScreen(Icons.car_crash_rounded, Strings.sellCar)),
      ],
    ),
  );
}