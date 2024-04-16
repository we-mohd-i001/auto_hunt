import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';

Widget carInformationWidget(
  IconData icon, {
  String informationType = 'Info',
  required String value,
  required double size,
}) {
  return ContainerWithRoundedBorder(
    width: size * 0.3,
    padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Icon(icon), Text(informationType), Text(value)],
    ),
  );
}
