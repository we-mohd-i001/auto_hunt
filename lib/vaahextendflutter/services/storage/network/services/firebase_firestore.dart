import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'base_service.dart';

class NetworkStorageWithFirestore implements NetworkStorageService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser;

  final Map<String, CollectionSettings> _collections = {
    'vaah-flutter-collection': CollectionSettings(
      collectionName: 'vaah-flutter-collection',
      isShared: true,
    ),
  };

  @override
  Future<void> addCollection(String collectionName, bool isShared) async {
    assert(!_collections.containsKey(collectionName), 'The collection already exists');

    if (!_collections.containsKey(collectionName)) {
      _collections[collectionName] =
          CollectionSettings(collectionName: collectionName, isShared: isShared);
    }
  }

  @override
  Future<void> create({
    required String collectionName,
    required String key,
    required String value,
  }) async {
    try {
      _collections[collectionName]!.isShared
          ? await _firestore.doc('shared/${_collections[collectionName]!.collectionName}').set(
              {key: value},
              SetOptions(merge: true),
            )
          : await _firestore
              .doc('separate/user-id/${_collections[collectionName]!.collectionName}/$key')
              .set(
              {'data': value},
              SetOptions(merge: true),
            );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> createMany({
    required String collectionName,
    required Map<String, String> values,
  }) async {
    values.forEach((key, value) async {
      create(
        collectionName: collectionName,
        key: key,
        value: value,
      );
    });
  }

  @override
  Future<String?> read({
    required String collectionName,
    required String key,
  }) async {
    try {
      String? value;
      _collections[collectionName]!.isShared
          ? await _firestore
              .doc('shared/${_collections[collectionName]!.collectionName}')
              .get()
              .then((v) => value = v.data()?[key])
          : await _firestore
              .doc('separate/user-id/${_collections[collectionName]!.collectionName}/$key')
              .get()
              .then((v) => value = v.data()?['data']);
      return value;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Map<String, String?>> readMany({
    required String collectionName,
    List<String> keys = const [],
  }) async {
    Map<String, String?> values = {};
    for (int i = 0; i < keys.length; i++) {
      values[keys[i]] = await read(collectionName: collectionName, key: keys[i]);
    }
    return values;
  }

  @override
  Future<void> delete({required String collectionName, required String key}) async {
    try {
      _collections[collectionName]!.isShared
          ? _firestore
              .doc('shared/${_collections[collectionName]!.collectionName}')
              .update({key: FieldValue.delete()})
          : await _firestore
              .doc('separate/user-id/${_collections[collectionName]!.collectionName}/$key')
              .delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteMany({required String collectionName, required List<String> keys}) async {
    for (int i = 0; i < keys.length; i++) {
      delete(collectionName: collectionName, key: keys[i]);
    }
  }

  @override
  Future<void> createOrUpdate(
      {required String collectionName, required String key, required String value}) {
    // TODO: implement createOrUpdate
    throw UnimplementedError();
  }

  @override
  Future<void> createOrUpdateMany(
      {required String collectionName, required Map<String, String> values}) {
    // TODO: implement createOrUpdateMany
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String?>> readAll({required String collectionName}) {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<void> update(
      {required String collectionName, required String key, required String value}) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> updateMany({required String collectionName, required Map<String, String> values}) {
    // TODO: implement updateMany
    throw UnimplementedError();
  }
}

class CollectionSettings {
  final String collectionName;
  final bool isShared;

  CollectionSettings({required this.collectionName, this.isShared = false});
}
