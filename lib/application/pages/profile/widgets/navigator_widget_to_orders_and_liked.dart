import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'icon_with_text.dart';

Widget navigatorWidgetToOrdersAndLiked() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
    decoration: BoxDecoration(
        color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
    child: Column(
      children: [
        iconWithText(Icons.list_alt_rounded, 'My Orders'),
        const SizedBox(height: 14),
        const Divider(),
        const SizedBox(height: 14),
        iconWithText(FontAwesomeIcons.heart, 'Liked Cars'),
        const SizedBox(height: 14),
        const Divider(),
        const SizedBox(height: 14),
        iconWithText(Icons.chat_bubble_outline_rounded, 'Messages')
      ],
    ),
  );
}
