import 'package:flutter/material.dart';

import '../../../../constants/strings/strings.dart';

Widget locationAndProfile({required String image}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.location,
              style: TextStyle(color: Colors.white70),
            ),
            Text('Dwarka, New Delhi',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
        CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(image),
        ),
      ],
    ),
  );
}
