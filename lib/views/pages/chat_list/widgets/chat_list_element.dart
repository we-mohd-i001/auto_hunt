import 'package:flutter/material.dart';

import '../../../../vaahextendflutter/helpers/constants.dart';
import 'sender_logo.dart';
import 'sender_name_and_last_message.dart';

class ChatListElement extends StatelessWidget {
  final String name;
  final String lastMessage;
  final Function() onPressed;
  const ChatListElement(
      {super.key,
      required this.name,
      required this.lastMessage,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            const SenderLogo(),
            horizontalMargin12,
            SenderNamerAndLastMessage(name: name, lastMessage: lastMessage),
          ],
        ),
      ),
    );
  }
}
