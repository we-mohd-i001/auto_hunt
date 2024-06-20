import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../storage.dart';

class FirestoreStorageImpl implements Storage {
  final String collectionName;
  final bool isShared;
  FirestoreStorageImpl({
    required this.collectionName,
    required this.isShared,
  });

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser;

  ///in case of multiple documents the methods take List<documentName>
  ///and List<jsonData> as argument and returns List<jsonResult>

  @override
  Future<void> init() async {
    if (_auth.currentUser != null && !isShared) {
      currentUser = _auth.currentUser;
    } else {
      throw FirebaseAuthException(
          code: '',
          message: 'The FirebaseAuth.intance.currentUser returns null, User not authenticated. '
              'Handle this exception to ensure unauthorized access to firestore.');
    }
  }

  @override
  Future<void> create({required String key, required String value}) async {
    try {
      isShared
          ? await _firestore.collection('shared').doc(collectionName).set(
              {key: value},
              SetOptions(merge: true),
            )
          : await _firestore
              .collection('separate')
              .doc('user-id')
              .collection(collectionName)
              .doc(key)
              .set(
              {'data': value},
              SetOptions(merge: true),
            );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> createAll({required Map<String, String> values}) async {
    values.forEach((key, value) async {
      create(key: key, value: value);
    });
  }

  @override
  Future<String?> read({required String key}) async {
    try {
      String? value;
      isShared
          ? await _firestore
              .collection('shared')
              .doc(collectionName)
              .get()
              .then((v) => value = v.data()?[key])
          : await _firestore
              .collection('separate')
              .doc('user-id')
              .collection(collectionName)
              .doc(key)
              .get()
              .then((v) => value = v.data()?['data']);
      return value;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, String?>> readAll({List<String> keys = const []}) async {
    Map<String, String?> values = {};
    for (int i = 0; i < keys.length; i++) {
      values[keys[i]] = await read(key: keys[i]);
    }
    return values;
  }

  @override
  Future<void> delete({required String key}) async {
    try {
      isShared
          ? _firestore.collection('shared').doc(collectionName).update({key: FieldValue.delete()})
          : await _firestore
              .collection('separate')
              .doc('userp-id')
              .collection(collectionName)
              .doc(key)
              .delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteAll({List<String> keys = const []}) async {
    for (int i = 0; i < keys.length; i++) {
      delete(key: keys[i]);
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
