import 'package:flutter/material.dart';

import '../../../../helpers/constants/strings/strings.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import 'options_home_screen.dart';

class HomeScreenOptions extends StatelessWidget {
  const HomeScreenOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: double.infinity,
      color: AppTheme.colors['primary'],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Expanded(
              flex: 0,
              child: OptionsHomeScreen(
                  icon: Icons.car_rental_rounded, text: Strings.rentCar)),
          VerticalDivider(
            color: AppTheme.colors['secondary']![400],
            indent: 10,
            thickness: 1,
            endIndent: 10,
          ),
          const Expanded(
              flex: 0,
              child: OptionsHomeScreen(
                  icon: Icons.car_repair_rounded, text: Strings.buyCar)),
          VerticalDivider(
            color: AppTheme.colors['secondary']![400],
            indent: 10,
            thickness: 1,
            endIndent: 10,
          ),
          const Expanded(
              flex: 0,
              child: OptionsHomeScreen(
                  icon: Icons.car_crash_rounded, text: Strings.sellCar)),
        ],
      ),
    );
  }
}
