import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';

Widget carBioMini() {
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
                'https://imgd.aeplcdn.com/1056x594/n/cw/ec/26742/swift-exterior-front-view.jpeg?q=80&wm=1',
                fit: BoxFit.cover,
              )),
        ),
        horizontalMargin8,
        horizontalMargin8,
        const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Car Name'),
            Text('Current Fuel Capacity - Engine Type'),
          ],
        )
      ],
    ),
  );
}
