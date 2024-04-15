// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'app_name.dart';
import 'logo_icon.dart';

class LogoWithName extends StatelessWidget {
  final double size;
  final MainAxisAlignment mainAxisAlignment;
  const LogoWithName(
      {Key? key,
      this.size = 10,
      this.mainAxisAlignment = MainAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Hero(
            tag: 'logo-icon',
            child: LogoIcon(
              size: size,
            )),
        SizedBox(
          width: size / 2,
        ),
        AppName(
          size: size,
        )
      ],
    );
  }
}
