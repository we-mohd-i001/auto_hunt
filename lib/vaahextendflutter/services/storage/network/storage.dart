import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../env.dart';
import 'services/base_service.dart';
import 'services/firebase_firestore.dart';
import 'services/no_op_storage.dart';
import 'services/supabase.dart';

NetworkStorageService get instanceNetwork {
  EnvironmentConfig envConfig = EnvironmentConfig.getEnvConfig();
  switch (envConfig.networkStorageType) {
    case NetworkStorageType.firebase:
      return NetworkStorageWithFirestore();
    case NetworkStorageType.supabase:
      return NetworkStorageWithSupabase();
    default:
      return NoOpNetworkStorage();
  }
}

abstract class NetworkStorage {
  static final NetworkStorageService _instanceNetwork = instanceNetwork;
  static const String _vaahFlutterCollection = 'vaah-flutter-collection';

  static Future<void> create({
    String collectionName = _vaahFlutterCollection,
    required String key,
    required Map<String, dynamic> value,
  }) async {
    return _instanceNetwork.create(collectionName: collectionName, key: key, value: value);
  }

  static Future<void> createMany({
    String collectionName = _vaahFlutterCollection,
    required Map<String, Map<String, dynamic>> values,
  }) async {
    return _instanceNetwork.createMany(collectionName: collectionName, values: values);
  }

  static GetData read({
    String collectionName = _vaahFlutterCollection,
    required String key,
  }) {
    return _instanceNetwork.read(collectionName: collectionName, key: key);
  }

  static Future<Map<String, GetData>> readMany({
    String collectionName = _vaahFlutterCollection,
    required List<String> keys,
  }) async {
    return _instanceNetwork.readMany(collectionName: collectionName, keys: keys);
  }

  static Future<Map<String, Map<String, dynamic>?>> readAll({required String collectionName}) {
    return _instanceNetwork.readAll(collectionName: collectionName);
  }

  static Future<void> update({
    required String collectionName,
    required String key,
    required Map<String, dynamic> value,
  }) async {
    return _instanceNetwork.update(collectionName: collectionName, key: key, value: value);
  }

  static Future<void> updateMany({
    String collectionName = _vaahFlutterCollection,
    required Map<String, Map<String, dynamic>> values,
  }) async {
    return _instanceNetwork.updateMany(collectionName: collectionName, values: values);
  }

  static Future<void> createOrUpdate({
    String collectionName = _vaahFlutterCollection,
    required String key,
    required Map<String, dynamic> value,
  }) async {
    return _instanceNetwork.createOrUpdate(collectionName: collectionName, key: key, value: value);
  }

  static Future<void> createOrUpdateMany({
    String collectionName = _vaahFlutterCollection,
    required Map<String, Map<String, dynamic>> values,
  }) async {
    return _instanceNetwork.createOrUpdateMany(collectionName: collectionName, values: values);
  }

  static Future<void> delete({
    String collectionName = _vaahFlutterCollection,
    required String key,
  }) async {
    return _instanceNetwork.delete(collectionName: collectionName, key: key);
  }

  static Future<void> deleteMany({
    String collectionName = _vaahFlutterCollection,
    required List<String> keys,
  }) async {
    return _instanceNetwork.deleteMany(collectionName: collectionName, keys: keys);
  }

  static Future<void> deleteAll({
    String collectionName = _vaahFlutterCollection,
  }) async {
    return _instanceNetwork.deleteAll(collectionName: collectionName);
  }
}

abstract class GetData {
  Future<Map<String, dynamic>?> call();
  Future<Stream<Map<String, dynamic>>?> stream();
}

class GetFirestoreData implements GetData {
  final String collectionName;
  final String key;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GetFirestoreData({required this.collectionName, required this.key});

  @override
  Future<Map<String, dynamic>?> call() async {
    Map<String, dynamic>? value = {};
    await firestore.doc('$collectionName/$key').get().then((v) => value = v.data());
    return value;
  }

  @override
  Future<Stream<Map<String, dynamic>>> stream() async {
    return firestore.doc('$collectionName/$key').snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.data()!;
      } else {
        return {};
      }
    });
  }
}

class GetSupabaseData implements GetData {
  final String collectionName;
  final String key;

  GetSupabaseData({required this.collectionName, required this.key});

  @override
  stream() {
    // TODO: implement stream
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>?> call() async {
    final supabase = Supabase.instance.client;
    final data = await supabase.from(collectionName).select();
    Map<String, dynamic> map = data[0];
    map.remove('key');
    return map;
  }
}

class GetNoData implements GetData {
  @override
  Future<Stream<Map<String, dynamic>>?> stream() async {
    return null;
  }

  @override
  Future<Map<String, dynamic>?> call() async {
    return null;
  }
}
