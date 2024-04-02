import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourtasks/controllers/main_navigator_controller.dart';

import '../constants/consts.dart';
import 'profile_controller.dart';

class ChatController extends GetxController {
  CollectionReference<Map<String, dynamic>> chats =
      firestore.collection(chatsCollection);
  User? currentUser = Get.find<ProfileController>().currentUser;
  String friendName = Get.arguments[0];
  String friendId = Get.arguments[1];
  String currentId = Get.find<ProfileController>().currentUser!.uid;
  String? userName = '';
  String? senderName = Get.find<MainNavigatorController>().userName;
  RxBool areChatsLoading = false.obs;
  TextEditingController messageController = TextEditingController();

  dynamic chatDocId;

  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  Future<void> getChatId() async {
    areChatsLoading(true);
    await chats
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot snapshot) {
            if (snapshot.docs.isNotEmpty) {
              chatDocId = snapshot.docs.single.id;
            } else {
              chats.add(
                {
                  'created_on': null,
                  'last_message': '',
                  'users': {friendId: null, currentId: null},
                  'to_id': '',
                  'from_id': '',
                  'friend_name': friendName,
                  'sender_name': senderName,
                },
              ).then((value) {
                chatDocId = value.id;
              });
            }
          },
        );
    areChatsLoading(false);
  }

  void sendMessage({required String message}) async {
    if (message.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_message': message,
        'to_id': friendId,
        'from_id': currentId,
      });
      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'message': message,
        'uid': currentId,
      });
    }
  }
}
