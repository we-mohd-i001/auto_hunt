import 'package:flutter/material.dart';

import '../../../helpers/commons.dart';

class ListHeading extends StatelessWidget {
  final String subHeadingRight;
  final String heading;
  const ListHeading(
      {super.key, required this.subHeadingRight, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(heading, style: normalBlack),
          Text(subHeadingRight, style: small)
        ],
      ),
    );
  }
}
