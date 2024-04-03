import 'package:get/get.dart';

import '../constants/consts.dart';
import '../data/chat/chat_model.dart';

class ChatListController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxList<ChatModel> chatList = <ChatModel>[].obs;
  dynamic chatDocId;

  void getChatList(String currentId) async {
    isLoading(true);
    try {
      await firestore
          .collection(chatsCollection)
          .withConverter(
              fromFirestore: ChatModel.fromFirestore,
              toFirestore: (ChatModel chatModel, _) => chatModel.toFireStore())
          .get()
          .then((querySnapshot) {
        var docSnapshot = querySnapshot.docs;
        chatList.assignAll(docSnapshot.map((doc) => doc.data.call()).toList());
        for (var docSnapShot in querySnapshot.docs) {
          print('${docSnapShot.id} => ${docSnapShot.data.call().lastMessage}');
        }
      });
      isLoading(false);
    } catch (e) {
      print('Error : ${e.toString()}');
    }
  }
}
