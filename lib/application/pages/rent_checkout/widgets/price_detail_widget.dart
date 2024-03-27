import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../../views/pages/ui/components/commons.dart';
import 'price_details_content.dart';

Widget priceDetailWidget(
    {required rentPrice, required days, required tax, required String total}) {
  return ContainerWithRoundedBorder(
      padding: allPadding0,
      borderRadius: 8,
      width: double.infinity,
      color: Colors.grey.shade200,
      child: Column(
        children: [
          verticalMargin8,
          priceDetailContent(
              'Rent Price', '₹ $rentPrice x${days.value.toStringAsFixed(0)}'),
          verticalMargin8,
          priceDetailContent(
              'Rent Duration', '${days.value.toStringAsFixed(0)} Days'),
          verticalMargin8,
          priceDetailContent('Tax', '₹ $tax'),
          verticalMargin16,
          Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              padding: allPadding12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: heading,
                  ),
                  Text(
                    '₹ $total',
                    style: heading,
                  )
                ],
              )),
        ],
      ));
}
