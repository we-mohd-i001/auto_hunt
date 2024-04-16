import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../vaahextendflutter/helpers/enums.dart';
import '../../../../vaahextendflutter/widgets/atoms/buttons.dart';

Widget editProfileButton(onPressed) {
  return Align(
    alignment: Alignment.topRight,
    child: ButtonTextWithIcon(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      buttonType: ButtonType.primary,
      onPressed: onPressed,
      text: 'Edit Profile',
      iconData: FontAwesomeIcons.pencil,
    ),
  );
}
