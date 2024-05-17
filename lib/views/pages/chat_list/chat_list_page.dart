import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../vaahextendflutter/services/logging_library/logging_library.dart';
import '../../../controllers/chat/chat_list_controller.dart';
import '../../../models/chat/chat_model.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../helpers/commons.dart';
import '../chat/chat_page.dart';
import '../common_widgets/custom_appbar.dart';
import 'widgets/chat_list_element.dart';

class ChatListPage extends StatelessWidget {
  final User? user;
  const ChatListPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    ChatListController chatListController = Get.put(ChatListController());
    return Scaffold(
      backgroundColor: AppTheme.colors['secondary']![100],
      appBar: customAppBar(implyLeading: false, title: 'Chats'),
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
                'ChatList loaded with ${snapshot.requireData.docs.length} chats.');
            return ListView.builder(
              itemCount: snapshot.requireData.docs.length,
              itemBuilder: (BuildContext context, int index) {
                ChatModel chatModel =
                    snapshot.requireData.docs[index].data.call();
                if (snapshot.requireData.docs.isEmpty) {
                  return const Center(
                    child: Text('No chats!'),
                  );
                }
                return ChatListElement(
                  name: chatModel.friendName.toString(),
                  lastMessage: chatModel.lastMessage.toString(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      ChatPage.route(chatModel.friendName, chatModel.toId),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
