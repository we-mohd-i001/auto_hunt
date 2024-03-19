import 'package:flutter/material.dart';
import '../../../../vaahextendflutter/widgets/atoms/buttons.dart';

Widget profileData(image, name, email, onPressed) {
  return Row(
    children: [
      Hero(
        tag: 'edit-profile',
        child: CircleAvatar(
          foregroundImage: NetworkImage(image),
          radius: 32,
        ),
      ),
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(color: Colors.white),),
          Text(email, style: TextStyle(color: Colors.white),),
        ],
      ),
      const Spacer(),
      ButtonOutlinedWithIcon(

        iconData: Icons.logout_rounded,
        text: 'Log Out',
        onPressed: onPressed,
      ),
    ],
  );
}
