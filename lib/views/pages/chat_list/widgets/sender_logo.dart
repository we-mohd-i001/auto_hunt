import 'package:flutter/material.dart';

import '../../../../helpers/constants/others/other_consts.dart';

class SenderLogo extends StatelessWidget {
  const SenderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 40,
      width: 40,
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          OtherConsts.bmwLogo,
        ),
      ),
    );
  }
}
