import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/app_theme.dart';
import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../../helpers/commons.dart';

class CarBioMini extends StatelessWidget {
  final String carIcon;
  final String carName;
  final String currentFuelCapacity;
  final String carFuelType;

  const CarBioMini(
      {super.key,
      required this.carIcon,
      required this.carName,
      required this.currentFuelCapacity,
      required this.carFuelType});

  @override
  Widget build(BuildContext context) {
    return ContainerWithRoundedBorder(
      padding: allPadding16,
      borderRadius: 8,
      color: AppTheme.colors['white'] as Color,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
                height: 60,
                width: 60,
                child: Image.network(
                  carIcon,
                  fit: BoxFit.cover,
                )),
          ),
          horizontalMargin8,
          horizontalMargin8,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                carName,
                style: normal,
              ),
              Text(
                '$currentFuelCapacity - $carFuelType',
                style: normal,
              ),
            ],
          )
        ],
      ),
    );
  }
}
