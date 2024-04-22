import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/app_theme.dart';
import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../../helpers/commons.dart';
import 'price_details_content.dart';

class PriceDetailWidget extends StatelessWidget {
  final int rentPrice;
  final double days;
  final int tax;
  final String total;
  const PriceDetailWidget(
      {super.key,
      required this.rentPrice,
      required this.days,
      required this.tax,
      required this.total});

  @override
  Widget build(BuildContext context) {
    return ContainerWithRoundedBorder(
      padding: allPadding0,
      borderRadius: 8,
      width: double.infinity,
      color: AppTheme.colors['white'] as Color,
      child: Column(
        children: [
          verticalMargin8,
          PriceDetailContent(
              title: 'Rent Price',
              content: '₹ $rentPrice x${days.toStringAsFixed(0)}'),
          verticalMargin8,
          PriceDetailContent(
              title: 'Rent Duration',
              content: '${days.toStringAsFixed(0)} Days'),
          verticalMargin8,
          PriceDetailContent(title: 'Tax', content: '₹ $tax'),
          verticalMargin16,
          Container(
              decoration: BoxDecoration(
                  color: AppTheme.colors['white'],
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
      ),
    );
  }
}
