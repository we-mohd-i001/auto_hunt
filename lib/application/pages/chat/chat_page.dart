import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourtasks/services/firestore_services.dart';

import '../../../constants/constants.dart';
import '../../../controllers/chat_controller.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../vaahextendflutter/widgets/atoms/input_text.dart';
import '../../../views/pages/ui/components/commons.dart';
import 'widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? theUser = auth.currentUser!;

    ChatController chatController = Get.put(ChatController());
    chatController.getChatId(theUser.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text('${Strings.chatWith} ${chatController.friendName}',
            style: normal),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Obx(
                  () => chatController.areChatsLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: StreamBuilder(
                            stream: chatController.getChatMessages(
                                docId: chatController.chatDocId.toString()),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: ((context, index) {
                                    DocumentSnapshot data =
                                        snapshot.data!.docs[index];
                                    return Align(
                                        alignment: data['uid'] == theUser.uid
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: chatBubble(
                                            data: data,
                                            isSender:
                                                data['uid'] == theUser.uid));
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
            Align(
              alignment: Alignment.bottomCenter,
              child: ContainerWithRoundedBorder(
                borderRadius: 8,
                padding: allPadding0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: InputText(
                    controller: chatController.messageController,
                    label: 'Type a message...',
                    suffixIcon: Icons.send_rounded,
                    suffixOnTap: () {
                      chatController.sendMessage(
                          currentId: theUser.uid,
                          message: chatController.messageController.text);
                      chatController.messageController.clear();
                    },
                  ),
                ),
              ),
            ),
            verticalMargin8,
          ],
        ),
      ),
    );
  }
}
