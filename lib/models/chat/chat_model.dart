import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  DateTime? createdOn;
  String? friendName;
  String? fromId;
  String? lastMessage;
  String? senderName;
  DateTime? lastMessageCreatedTime;
  String? toId;
  List<String?>? users;
  ChatModel({
    required this.createdOn,
    required this.friendName,
    required this.fromId,
    required this.lastMessage,
    required this.senderName,
    required this.toId,
    required this.users,
    required this.lastMessageCreatedTime,
  });
  factory ChatModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ChatModel(
      createdOn: (data?['created_on'] == null)
          ? DateTime.now()
          : data?['created_on'].toDate(),
      friendName: data?['friend_name'],
      fromId: data?['from_id'],
      lastMessage: data?['last_message'],
      senderName: data?['sender_name'],
      toId: data?['to_id'],
      users: data?['users'] is Iterable ? List.from(data?['regions']) : null,
      lastMessageCreatedTime: (data?['last_message_created_time'] == null)
          ? DateTime.now()
          : data?['last_message_created_time'].toDate(),
    );
  }
  Map<String, dynamic> toFireStore() {
    return {
      if (createdOn != null) "created_on": createdOn,
      if (friendName != null) "friend_name": friendName,
      if (fromId != null) "from_id": fromId,
      if (lastMessage != null) "last_message": lastMessage,
      if (senderName != null) "sender_name": senderName,
      if (toId != null) "to_id": toId,
      if (users != null) "users": users,
      if (lastMessageCreatedTime != null)
        "last_message_created_time": lastMessageCreatedTime,
    };
  }
}
