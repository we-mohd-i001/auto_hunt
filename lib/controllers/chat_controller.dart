import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/constants/consts.dart';
import '../vaahextendflutter/helpers/alerts.dart';
import '../vaahextendflutter/services/logging_library/logging_library.dart';
import 'main_navigator_controller.dart';
import 'profile_controller.dart';

class ChatController extends GetxController {
  ChatController({
    required this.friendName,
    required this.friendId,
  });
  String friendName;
  String friendId;

  CollectionReference<Map<String, dynamic>> chats =
      firestore.collection(chatsCollection);
  User? currentUser = Get.find<ProfileController>().currentFirebaseUser;

  String? senderName = Get.find<MainNavigatorController>().userName;
  RxBool isLoading = false.obs;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  dynamic chatDocId;

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatMessages(
      {required String docId}) {
    Log.info('Loading Chat Messages...');
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: true)
        .snapshots();
  }

  Future<void> getChatId(String currentId) async {
    try {
      Log.info('Loading Chat Id...');
      isLoading(true);
      await chats
          .where('users', isEqualTo: {friendId: null, currentId: null})
          .limit(1)
          .get()
          .then(
            (QuerySnapshot snapshot) {
              if (snapshot.docs.isNotEmpty) {
                chatDocId = snapshot.docs.single.id;
                Log.success('Chat id Loaded. $chatDocId');
              } else {
                Log.info('Chat id do not exists creating a new chat id...');
                chats.add(
                  {
                    'created_on': null,
                    'last_message': '',
                    'users': {friendId: null, currentId: null},
                    'to_id': '',
                    'from_id': '',
                    'last_message_created_time': null,
                    'friend_name': friendName,
                    'sender_name': senderName,
                  },
                ).then((value) {
                  chatDocId = value.id;
                  Log.success('Created a new chat id $chatDocId.');
                });
              }
            },
          );
      isLoading(false);
    } on Exception catch (_) {
      Alerts.showErrorToast!(content: 'Something went wrong!');
    }
  }

  void sendMessage({required String message, required String currentId}) async {
    try {
      Log.info('sendMessage invoked!');
      if (message.trim().isNotEmpty) {
        Log.info('Message is not empty $message');
        chats.doc(chatDocId).update({
          'created_on': FieldValue.serverTimestamp(),
          'last_message': message,
          'last_message_created_time': FieldValue.serverTimestamp(),
          'to_id': friendId,
          'from_id': currentId,
        });
        Log.info('Update the chats document in firestore with id : $chatDocId');
        chats.doc(chatDocId).collection(messagesCollection).doc().set({
          'created_on': FieldValue.serverTimestamp(),
          'message': message,
          'uid': currentId,
        });
        Log.info('Message sent/received successfully.');
      } else {
        Log.info('''Can't send empty message.''');
      }
    } on Exception catch (e) {
      Alerts.showErrorToast!(content: 'Something went wrong!');
      Log.exception('Exception : $e');
    }
  }
}
