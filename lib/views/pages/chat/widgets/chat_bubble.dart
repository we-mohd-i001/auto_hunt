import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/date_time.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../helpers/commons.dart';

class ChatBubble extends StatelessWidget {
  final DocumentSnapshot data;
  final bool isSender;

  const ChatBubble({super.key, required this.data, required this.isSender});

  @override
  Widget build(BuildContext context) {
    DateTime messageTime = data['created_on'] == null
        ? DateTime.now()
        : data['created_on'].toDate();
    String messageTimeString = messageTime.toHMaa;
    return Padding(
      padding: isSender
          ? const EdgeInsets.only(top: 0, bottom: 8, left: 40, right: 8)
          : const EdgeInsets.only(top: 0, bottom: 8, left: 8, right: 40),
      child: Container(
        padding: allPadding12,
        decoration: BoxDecoration(
            color: isSender
                ? AppTheme.colors['warning']![100]
                : AppTheme.colors['white']![50],
            borderRadius: isSender
                ? const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24),
                  ),
            border:
                Border.all(color: AppTheme.colors['secondary']![300] as Color)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(
            data['message'],
            textAlign: TextAlign.start,
            style: message,
          ),
          Text(
            messageTimeString,
            style: small,
            textAlign: TextAlign.end,
          ),
        ]),
      ),
    );
  }
}
