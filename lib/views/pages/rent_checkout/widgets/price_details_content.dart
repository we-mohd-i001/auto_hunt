import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../helpers/commons.dart';

class PriceDetailContent extends StatelessWidget {
  final String title;
  final String content;

  const PriceDetailContent(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: horizontalPadding12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: normal,
          ),
          Text(
            content,
            style: normal,
          ),
        ],
      ),
    );
  }
}
