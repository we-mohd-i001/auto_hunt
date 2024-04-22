import 'package:flutter/material.dart';

import '../../../../helpers/commons.dart';
import '../../../../helpers/constants/strings/strings.dart';

class LocationAndProfileImage extends StatelessWidget {
  final String image;
  final String location;
  const LocationAndProfileImage({
    super.key,
    required this.image,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
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
          CircleAvatar(
            radius: 32,
            backgroundImage: NetworkImage(image),
          ),
        ],
      ),
    );
  }
}
