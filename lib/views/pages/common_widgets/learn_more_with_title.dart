import 'package:flutter/material.dart';

import '../../../helpers/constants/constants.dart';
import '../../../helpers/commons.dart';

Widget learnMoreWithTitle(title, {String changeLearnMore = Strings.learnMore}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: normalBlack),
        Text(changeLearnMore, style: small)
      ],
    ),
  );
}
