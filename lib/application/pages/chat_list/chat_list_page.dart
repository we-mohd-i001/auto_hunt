import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/others/other_consts.dart';
import '../../../controllers/chat_list_controller.dart';
import '../../../data/chat/chat_model.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../views/pages/ui/components/commons.dart';
import '../chat/chat_page.dart';

class ChatListPage extends StatelessWidget {
  final User? theUser;
  const ChatListPage({super.key, required this.theUser});

  @override
  Widget build(BuildContext context) {
    ChatListController chatListController = Get.put(ChatListController());
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          'Chats',
          style: subheading,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: chatListController.getChatList(theUser!.uid),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<ChatModel>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    ChatModel chatModel =
                        snapshot.data!.docs[index].data.call();
                    return ChatListElement(
                      name: chatModel.friendName.toString(),
                      lastMessage: chatModel.lastMessage.toString(),
                      onPressed: () {
                        Get.to(() => const ChatPage(),
                            arguments: [chatModel.friendName, chatModel.toId]);
                      },
                    );
                  });
            }),
      ),
    );
  }
}

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
            SizedBox(
              height: 40,
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: subheading,
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
            ),
          ],
        ),
      ),
    );
  }
}
