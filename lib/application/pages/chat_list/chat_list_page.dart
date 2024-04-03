import 'package:flutter/material.dart';

import '../../../constants/others/other_consts.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../views/pages/ui/components/commons.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          'Chats',
          style: subheading,
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ChatListElement(),
              ChatListElement(),
              ChatListElement(),
              ChatListElement(),
              ChatListElement(),
              ChatListElement(),
              ChatListElement(),
              ChatListElement(),
              ChatListElement(),
              ChatListElement(),
              ChatListElement(),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatListElement extends StatelessWidget {
  const ChatListElement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey)),
        ),
        child: Row(
          children: [
            const SizedBox(
              height: 40,
              width: 40,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  OtherConsts.bmwLogo,
                ),
              ),
            ),
            horizontalMargin12,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: subheading,
                ),
                Text(
                  'Last Message',
                  style: normal,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
