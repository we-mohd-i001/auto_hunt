import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yourtasks/vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import 'icon_with_text.dart';

class NavigatorWidgetToOrdersAndLiked extends StatelessWidget {
  final void Function()? myOrdersOnPressed;
  final void Function()? likedCarsOnPressed;
  final void Function()? messagesOnPressed;
  const NavigatorWidgetToOrdersAndLiked(
      {super.key,
      this.myOrdersOnPressed,
      this.likedCarsOnPressed,
      this.messagesOnPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
      decoration: BoxDecoration(
          color: AppTheme.colors['white'],
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          IconWithText(
              icon: Icons.list_alt_rounded,
              text: 'My Orders',
              onPressed: myOrdersOnPressed ?? () {}),
          verticalMargin12,
          const Divider(),
          verticalMargin12,
          IconWithText(
              icon: FontAwesomeIcons.heart,
              text: 'Liked Cars',
              onPressed: likedCarsOnPressed ?? () {}),
          verticalMargin12,
          const Divider(),
          verticalMargin12,
          IconWithText(
              icon: Icons.chat_bubble_outline_rounded,
              text: 'Messages',
              onPressed: messagesOnPressed ?? () {})
        ],
      ),
    );
  }
}
