import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';

Widget carBioMini(
    {required String carIcon,
    required String carName,
    required String currentFuelCapacity,
    required String carFuelType}) {
  return ContainerWithRoundedBorder(
    padding: allPadding16,
    borderRadius: 8,
    color: Colors.grey.shade200,
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
            Text(carName),
            Text('$currentFuelCapacity - $carFuelType'),
          ],
        )
      ],
    ),
  );
}
