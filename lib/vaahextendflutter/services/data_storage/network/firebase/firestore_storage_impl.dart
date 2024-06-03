import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../storage.dart';

class FirestoreStorageImpl extends Storage {
  final String collectionName;
  FirestoreStorageImpl(this._firestoreRepository, {required this.collectionName});

  final FirestoreRepository _firestoreRepository;
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
}

abstract class FirestoreRepository {
  Future<void> setData(String path, Map<String, dynamic> data);
  Future<void> updateData(String path, Map<String, dynamic> data);
  Future<void> deleteData(String path);
  Future<DocumentSnapshot> getData(String path);
  Stream<DocumentSnapshot> getDocumentStream(String path);
  Future<QuerySnapshot> getCollection(String path);
  Stream<QuerySnapshot> getCollectionStream(String path);
}

class FirestoreRepositoryImpl implements FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> setData(String path, Map<String, dynamic> data) async {
    await _firestore.doc(path).set(data);
  }

  @override
  Future<void> updateData(String path, Map<String, dynamic> data) async {
    await _firestore.doc(path).update(data);
  }

  @override
  Future<void> deleteData(String path) async {
    await _firestore.doc(path).delete();
  }

  @override
  Future<DocumentSnapshot> getData(String path) async {
    return await _firestore.doc(path).get();
  }

  @override
  Stream<DocumentSnapshot> getDocumentStream(String path) {
    return _firestore.doc(path).snapshots();
  }

  @override
  Future<QuerySnapshot> getCollection(String path) async {
    return await _firestore.collection(path).get();
  }

  @override
  Stream<QuerySnapshot> getCollectionStream(String path) {
    return _firestore.collection(path).snapshots();
  }
}
