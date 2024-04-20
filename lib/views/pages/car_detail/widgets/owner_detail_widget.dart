import 'package:flutter/material.dart';

import '../../../../helpers/commons.dart';
import '../../../../helpers/constants/constants.dart';
import '../../../../vaahextendflutter/helpers/constants.dart';

class OwnerDetailWidget extends StatelessWidget {
  final String? logoUrl;
  final String? ownerName;
  const OwnerDetailWidget({super.key, this.logoUrl, this.ownerName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Strings.carOwner, style: small),
        verticalMargin4,
        Row(
          children: [
            Image.network(
              logoUrl ?? '',
              height: 26,
              fit: BoxFit.contain,
            ),
            horizontalMargin4,
            Text(
              ownerName ?? 'Name',
              style: subheadingBlack,
            ),
          ],
        )
      ],
    );
  }
}
