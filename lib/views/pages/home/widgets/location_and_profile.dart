import 'package:flutter/material.dart';

import '../../../../helpers/commons.dart';
import '../../../../helpers/constants/strings/strings.dart';
import '../../../../vaahextendflutter/app_theme.dart';

Widget locationAndProfile(
    {required String image,
    required String location,
    required Function()? onPressedRefreshIcon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.location,
              style: normalWhite,
            ),
            SizedBox(
              width: 200,
              child: Text(
                location,
                style: headingWhite,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        // ButtonIcon(
        //     onPressed: onPressedRefreshIcon, iconData: Icons.refresh_rounded),
        CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(image),
        ),
      ],
    ),
  );
}
