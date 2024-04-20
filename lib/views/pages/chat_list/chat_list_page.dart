import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/others/other_consts.dart';
import '../../../controllers/chat_list_controller.dart';
import '../../../models/chat/chat_model.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../helpers/commons.dart';
import '../../../vaahextendflutter/services/logging_library/logging_library.dart';
import '../chat/chat_page.dart';

class ChatListPage extends StatelessWidget {
  final User? user;
  const ChatListPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    ChatListController chatListController = Get.put(ChatListController());
    return Scaffold(
      backgroundColor: AppTheme.colors['secondary']![100],
      appBar: AppBar(
        backgroundColor: AppTheme.colors['secondary']![100],
        foregroundColor: AppTheme.colors['secondary']![100],
        surfaceTintColor: AppTheme.colors['secondary']![100],
        title: Text(
          'Chats',
          style: subheading,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: chatListController.getChatList(user!.uid),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<ChatModel>> snapshot) {
              if (!snapshot.hasData) {
                Log.info('ChatList loaded with no snapshot data.');
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                Log.exception(
                    'ChatListPage snapshot has error ${snapshot.error}');
                return Center(
                  child: Text('Something went wrong!', style: normal),
                );
              }
              Log.success(
                  'ChatList loaded with ${snapshot.data!.docs.length} chats.');
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    ChatModel chatModel =
                        snapshot.data!.docs[index].data.call();
                    return ChatListElement(
                      name: chatModel.friendName.toString(),
                      lastMessage: chatModel.lastMessage.toString(),
                      onPressed: () {
                        Navigator.push(
                            context,
                            ChatPage.route(
                                chatModel.friendName, chatModel.toId));
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
            ),
          ],
        ),
      ),
    );
  }
}
