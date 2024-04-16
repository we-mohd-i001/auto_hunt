import 'package:flutter/material.dart';

import '../../../../helpers/constants/strings/strings.dart';

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
            const Text(
              Strings.location,
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(
              width: 200,
              child: Text(
                location,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
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
