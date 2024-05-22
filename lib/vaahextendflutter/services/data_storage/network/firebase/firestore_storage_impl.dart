import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../storage.dart';

class FirestoreStorageImpl {
  final String collectionName;
  FirestoreStorageImpl({required this.collectionName});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser;

  ///in case of multiple documents the methods take List<documentName>
  ///and List<jsonData> as argument and returns List<jsonResult>

  @override
  Future<void> create({dynamic key, dynamic value}) async {
    try {
      if (value is List<String> && key is List<String>) {
        if (key.length == value.length) {
          for (int i = 0; i < key.length; i++) {
            await _firestore.collection(collectionName).doc(key[i]).set({
              'data': value[i],
            });
          }
        } else {
          throw Exception('key list and value list Length mismatch.');
        }
      } else if (key is String && value is String) {
        await _firestore.collection(collectionName).doc(key).set({'data': value});
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  void delete({dynamic key}) {
    try {
      if (key is List<String>) {
        for (int i = 0; i < key.length; i++) {
          _firestore.collection(collectionName).doc(key[i]).delete();
        }
      } else {
        _firestore.collection(collectionName).doc(key).delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> init() async {
    if (_auth.currentUser != null) {
      currentUser = _auth.currentUser;
    } else {
      throw FirebaseAuthException(
          code: '',
          message:
              'The FirebaseAuth.intance.currentUser returns null, User not authenticated. Handle this exception to ensure unauthorized access to firestore.');
    }
  }

  @override
  Future<dynamic> read({dynamic key}) async {
    try {
      dynamic value;
      if (key is List<String>) {
        for (int i = 0; i < key.length; i++) {
          await _firestore
              .collection(collectionName)
              .doc(key[i])
              .get()
              .then((v) => value = v.data());
          return value;
        }
      }
      await _firestore
          .collection(collectionName)
          .doc(key)
          .get()
          .then((v) => value = v.data()!['data']);
      return value;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<dynamic> update({dynamic key, dynamic value}) async {
    try {
      if (key is List<String> && value is List<String>) {
        for (int i = 0; i < key.length; i++) {
          await _firestore
              .collection(collectionName)
              .doc(key[i])
              .set({'data': value[i]}, SetOptions(merge: true));
        }
      } else if (key is String && value is String) {
        await _firestore
            .collection(collectionName)
            .doc(key)
            .set({'data': value}, SetOptions(merge: true));
      }
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> createAll({required Map<String, String> values}) {
    // TODO: implement createAll
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll({List<String>? keys}) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String?>> readAll({List<String>? keys}) {
    // TODO: implement readAll
    throw UnimplementedError();
  }
}
