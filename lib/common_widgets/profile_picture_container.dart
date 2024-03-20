import 'package:flutter/material.dart';

Widget profilePictureContainer(image, radius) {
  return Hero(
          tag: 'edit-profile',
          child: CircleAvatar(
            radius: radius,
            backgroundImage: image,
          ),
        );
}
