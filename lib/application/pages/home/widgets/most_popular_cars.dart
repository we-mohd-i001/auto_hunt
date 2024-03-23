import 'package:flutter/material.dart';
import '../../../../constants/others/other_consts.dart';
import '../../../../constants/strings/strings.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import '../../common_widgets/car_bio.dart';

Widget mostPopularCars() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              carBio(
                'BMW M8 : M - Competition',
                'Paid - Diesel Car',
                OtherConsts.carBMWM8,
                220.0,
                3000,
                4
              ),
              carBio('Name', 'Type', OtherConsts.carBMW, 220.0, 3000, 4),
              carBio('Name', 'type', OtherConsts.carBMW, 220.0, 3000, 4)
            ],
          ),
        ),
      ),
    ],
  );
}
