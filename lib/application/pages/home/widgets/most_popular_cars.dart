import 'package:flutter/material.dart';
import '../../../../constants/others/other_consts.dart';
import '../../../../constants/strings/strings.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import 'car_bio.dart';

Widget mostPopularCars() {
  return Column(mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              Strings.mostPopularCars,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              Strings.learnMore,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppTheme.colors['secondary']),
            )
          ],
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [carBio('BMW M8 : M - Competition', 'Paid - Diesel Car', OtherConsts.carBMWM8,  ), carBio('Name', 'Type',OtherConsts.carBMW), carBio('Name', 'type',OtherConsts.carBMW)],
        ),
      ),
    ],
  );
}
