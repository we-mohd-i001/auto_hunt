import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  DateTime? createdOn;
  String? message;
  String? uid;
  MessageModel({
    required this.createdOn,
    required this.message,
    required this.uid,
  });

  factory MessageModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions options,
  ) {
    final data = snapshot.data();
    return MessageModel(
      createdOn: data?['created_on'],
      message: data?['message'],
      uid: data?['uid'],
    );
  }
  Map<String, dynamic> toFireStore() {
    return {
      if (createdOn != null) "created_on": createdOn,
      if (message != null) "message": message,
      if (uid != null) "uid": uid,
    };
  }
}
