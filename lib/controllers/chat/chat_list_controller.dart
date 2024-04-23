import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../helpers/constants/consts.dart';
import '../../models/chat/chat_model.dart';
import '../../vaahextendflutter/services/logging_library/logging_library.dart';

class ChatListController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxList<ChatModel> chatList = <ChatModel>[].obs;
  dynamic chatDocId;

  Stream<QuerySnapshot<ChatModel>> getChatList(String currentId) {
    isLoading(true);
    Log.info('Loading chats from $chatDocId');
    Stream<QuerySnapshot<ChatModel>> data = firestore
        .collection(chatsCollection)
        .withConverter(
            fromFirestore: ChatModel.fromFirestore,
            toFirestore: (ChatModel chatModel, _) => chatModel.toFireStore())
        .where('from_id', isEqualTo: currentId)
        .orderBy('created_on', descending: true)
        .snapshots();
    isLoading(false);
    return data;
  }
}
