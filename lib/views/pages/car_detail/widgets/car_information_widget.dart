import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../../helpers/commons.dart';

class CarInformationWidget extends StatelessWidget {
  final IconData icon;
  final String? informationType;
  final String value;
  final double size;
  const CarInformationWidget(
      {super.key,
      required this.icon,
      this.informationType,
      required this.value,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return ContainerWithRoundedBorder(
      width: size * 0.3,
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          Text(
            informationType ?? 'Info',
            style: normal,
          ),
          Text(
            value,
            style: normalBlack,
          )
        ],
      ),
    );
  }
}
