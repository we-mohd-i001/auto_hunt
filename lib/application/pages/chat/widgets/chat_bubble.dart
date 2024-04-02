import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/date_time.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../views/pages/ui/components/commons.dart';

Widget chatBubble({required DocumentSnapshot data, required bool isSender}) {
  DateTime messageTime =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  String messageTimeString = messageTime.toHMaa;
  return Padding(
    padding: isSender
        ? const EdgeInsets.only(top: 0, bottom: 8, left: 32, right: 8)
        : const EdgeInsets.only(top: 0, bottom: 8, left: 8, right: 32),
    child: Container(
      padding: allPadding8,
      decoration: BoxDecoration(
          color: AppTheme.colors['warning'] as MaterialColor,
          borderRadius: isSender
              ? const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(
          data['message'],
          textAlign: TextAlign.end,
          style: normal,
        ),
        Text(
          messageTimeString,
          style: normal,
          textAlign: TextAlign.end,
        ),
      ]),
    ),
  );
}
