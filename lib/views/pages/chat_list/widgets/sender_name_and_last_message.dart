import 'package:flutter/material.dart';

import '../../../../helpers/commons.dart';

class SenderNamerAndLastMessage extends StatelessWidget {
  final String name;
  final String lastMessage;
  const SenderNamerAndLastMessage(
      {super.key, required this.name, required this.lastMessage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: subheadingBlack,
          ),
          Expanded(
            child: Text(
              lastMessage,
              style: normal,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
