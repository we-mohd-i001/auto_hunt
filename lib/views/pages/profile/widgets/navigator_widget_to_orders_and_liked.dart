import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yourtasks/vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import 'icon_with_text.dart';

Widget navigatorWidgetToOrdersAndLiked(
    myOrdersOnPressed, likedCarsOnPressed, messagesOnPressed) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
    decoration: BoxDecoration(
        color: AppTheme.colors['white'],
        borderRadius: BorderRadius.circular(12)),
    child: Column(
      children: [
        iconWithText(Icons.list_alt_rounded, 'My Orders', myOrdersOnPressed),
        verticalMargin12,
        const Divider(),
        verticalMargin12,
        iconWithText(FontAwesomeIcons.heart, 'Liked Cars', likedCarsOnPressed),
        verticalMargin12,
        const Divider(),
        verticalMargin12,
        iconWithText(
            Icons.chat_bubble_outline_rounded, 'Messages', messagesOnPressed)
      ],
    ),
  );
}
