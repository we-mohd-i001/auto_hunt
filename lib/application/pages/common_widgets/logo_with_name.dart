import 'package:flutter/material.dart';

import 'app_name.dart';
import 'logo_icon.dart';

class LogoWithName extends StatelessWidget {
  final double size;
  const LogoWithName({
    this.size = 10,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Hero(
            tag: 'logo-icon',
            child: LogoIcon(
             size: size,
            )),
        SizedBox(
          width: size/2,
        ),
        AppName(size: size,)
      ],
    );
  }

}
