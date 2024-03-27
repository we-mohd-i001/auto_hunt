import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import 'price_details_content.dart';

Widget priceDetailWidget() {
  return ContainerWithRoundedBorder(
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Column(
        children: [
          priceDetailContent('Rent Price', '₹320 x2'),
          verticalMargin8,
          priceDetailContent('Rent Duration', '2 Days'),
          verticalMargin8,
          priceDetailContent('Tax', '₹500')
        ],
      ));
}