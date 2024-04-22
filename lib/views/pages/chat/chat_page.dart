import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/chat_controller.dart';
import '../../../helpers/constants/constants.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../helpers/commons.dart';
import '../common_widgets/custom_appbar.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/send_message_field.dart';

class ChatPage extends StatelessWidget {
  final String friendName;
  final String friendId;
  const ChatPage({
    Key? key,
    required this.friendName,
    required this.friendId,
  }) : super(key: key);

  static const String routePath = '/chat';

  static Route<void> route(friendName, friendId) {
    _initialize(friendName, friendId);
    return MaterialPageRoute(
        settings: const RouteSettings(name: routePath),
        builder: (_) => ChatPage(friendName: friendName, friendId: friendId));
  }

  static _initialize(friendName, friendId) {
    return Get.isRegistered<ChatController>()
        ? Get.find<ChatController>()
        : Get.put(
            ChatController(
              friendName: friendName,
              friendId: friendId,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser!;
    ChatController chatController = Get.find<ChatController>();

    chatController.getChatId(user.uid);

    void _sendMessage() {
      chatController.sendMessage(
        currentId: user.uid,
        message: chatController.messageController.text,
      );
      chatController.messageController.clear();
    }

    return Scaffold(
      backgroundColor: AppTheme.colors['secondary']![100],
      appBar: customAppBar(
        title: '${Strings.chatWith} ${chatController.friendName}',
        onPressed: () {
          Navigator.pop(context);
          Get.delete<ChatController>();
        },
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Obx(
                  () => chatController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: StreamBuilder(
                            stream: chatController.getChatMessages(
                                docId: chatController.chatDocId.toString()),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Something went wrong!',
                                      style: normal),
                                );
                              }
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.data!.docs.isEmpty) {
                                return Text(
                                  'Send a message...',
                                  style: normal,
                                );
                              } else {
                                return ListView.builder(
                                  reverse: true,
                                  shrinkWrap: true,
                                  controller: chatController.scrollController,
                                  itemCount: snapshot.requireData.docs.length,
                                  itemBuilder: ((context, index) {
                                    DocumentSnapshot data =
                                        snapshot.requireData.docs[index];
                                    return Align(
                                        alignment: data['uid'] == user.uid
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: ChatBubble(
                                            data: data,
                                            isSender: data['uid'] == user.uid));
                                  }),
                                );
                              }
                            },
                          ),
                        ),
                ),
                verticalMargin48,
                verticalMargin12
              ],
            ),
            SendMessageField(
              controller: chatController.messageController,
              onSendTap: _sendMessage,
            ),
            verticalMargin8,
          ],
        ),
      ),
    );
  }
}
