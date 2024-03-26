import 'package:flutter/material.dart';

import '../../../../constants/others/other_consts.dart';
import '../../common_widgets/car_bio.dart';

Widget mostPopularCars() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          carBio('BMW M8 : M - Competition', 'Paid - Diesel Car',
              OtherConsts.carBMWM8, 220.0, 3000, 4, () {},''),
          carBio('Name', 'Type', OtherConsts.carBMW, 220.0, 3000, 4, () {},'-'),
          carBio('Name', 'type', OtherConsts.carBMW, 220.0, 3000, 4, () {},'20')
        ],
      ),
    ),
  );
}
