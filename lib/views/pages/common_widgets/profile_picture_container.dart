import 'package:flutter/material.dart';

class ProfilePictureContainer extends StatelessWidget {
  final dynamic image;
  final double? radius;
  const ProfilePictureContainer(
      {super.key, required this.image, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'edit-profile',
      child: CircleAvatar(
        radius: radius,
        backgroundImage: image,
      ),
    );
  }
}
