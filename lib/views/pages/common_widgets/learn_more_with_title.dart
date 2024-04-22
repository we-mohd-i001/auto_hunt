import 'package:flutter/material.dart';

import '../../../helpers/constants/constants.dart';
import '../../../helpers/commons.dart';

class LearnMoreWithTitle extends StatelessWidget {
  final String? changeLearnMore;
  final String title;
  const LearnMoreWithTitle(
      {super.key, this.changeLearnMore, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: normalBlack),
          Text(changeLearnMore ?? Strings.learnMore, style: small)
        ],
      ),
    );
  }
}
