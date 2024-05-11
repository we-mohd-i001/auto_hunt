import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../env.dart';
import 'encrypted/flutter_secure_storage_encrypted.dart';
import 'encrypted/hive_encrypted_data_storage.dart';
import 'local/flutter_secure_storage/flutter_secure_storage_impl.dart';
import 'local/hive/hive_storage_impl.dart';
import 'network/firebase/firestore_storage_impl.dart';

abstract class Storage {
  static final EnvironmentConfig _envConfig = EnvironmentConfig.getEnvConfig();
  factory Storage.createLocal({String? name}) {
    switch (_envConfig.localStorageType) {
      case LocalStorageType.hive:
        final hive = HiveStorageImpl(name: name ?? 'default');
        hive.init();
        return hive;
      case LocalStorageType.flutterSecureStorage:
        return FlutterSecureStorageImpl();
      default:
        return NullStorage();
    }
  }

  factory Storage.createNetwork({String? name}) {
    switch (_envConfig.networkStorageType) {
      case NetworkStorageType.firebase:
        final firestore =
            FirestoreStorageImpl(collectionName: name ?? 'default');
        firestore.init();
        return firestore;
      case NetworkStorageType.supabase:
        return NullStorage();
      case NetworkStorageType.none:
        return NullStorage();
    }
  }

  factory Storage.createEncryptedLocal(String? name) {
    switch (_envConfig.localStorageType) {
      case LocalStorageType.hive:
        final hive = HiveLocalDataEncryptedStorage(name: name ?? 'default');
        return hive;
      case LocalStorageType.flutterSecureStorage:
        return FlutterSecureStorageLocalEncryptedDataStorage();
      default:
        return NullStorage();
    }
  }

  Storage();

  Future<void> init();

  Future<void> create({dynamic key, dynamic value});

  Future<dynamic> read({dynamic key});

  Future<dynamic> update({dynamic key, dynamic value});

  void delete({dynamic key});
}

abstract class NetworkStorage extends Storage {
  @override
  Future<void> init();

  @override
  Future<void> create({
    dynamic key,
    dynamic value,
  });

  @override
  Future<dynamic> read({dynamic key, List<String>? filters});

  @override
  Future<dynamic> update({dynamic key, dynamic value});

  @override
  void delete({dynamic key});
}

class SupabaseImpl implements NetworkStorage {
  final instance = Supabase.instance.client;

  @override
  Future<void> create({
    key,
    value,
  }) {
    instance.from(key).insert(value);
    throw UnimplementedError();
  }

  @override
  void delete({key}) {
    instance.from(key).delete();
  }

  @override
  Future<void> init() async {}

  @override
  Future<dynamic> read({key, List<String>? filters}) {
    return instance.from('key').select();
  }

  @override
  Future<dynamic> update({key, value}) {
    return instance.from(key).update(value);
  }
}

class NullStorage implements Storage {
  @override
  void delete({dynamic key}) {}

  @override
  Future<void> init() async {}

  @override
  Future<String?> read({dynamic key}) {
    throw UnimplementedError();
  }

  @override
  Future<String?> update({dynamic key, dynamic value}) {
    throw UnimplementedError();
  }

  @override
  Future<void> create({dynamic key, dynamic value}) {
    throw UnimplementedError();
  }
}

//   @override
//   void create(key, String data, bool isMultiple) {}
// }

// class SupabaseRemoteStorage implements Storage {
//   @override
//   void delete(dynamic key) {}

//   @override
//   Future<void> init() async {}

//   @override
//   Future<String?> read(dynamic key) {
//     throw UnimplementedError();
//   }

//   @override
//   Future<String?> update<T>(dynamic key, T data, bool isMultiple) {
//     throw UnimplementedError();
//   }

//   @override
//   void create(key, String data, bool isMultiple) {}
// }

abstract class DatabaseService {
  Future<dynamic> getDocument({Eq? eq});
  Future<dynamic> getCollection();
  Future<void> setDocument(Map<String, dynamic> data);
  Future<void> updateDocument(Map<String, dynamic> data, {Eq? eq});
  Future<void> deleteDocument();
}

class FirestoreService implements DatabaseService {
  final String collectionName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirestoreService({required this.collectionName});

  @override
  Future<dynamic> getDocument({Eq? eq}) async {
    try {
      final snapshot = await _firestore.doc(collectionName).get();
      return snapshot;
    } catch (e) {
      throw Exception('Failed to get document: $e');
    }
  }

  @override
  Future<List<dynamic>> getCollection() async {
    try {
      final snapshot = await _firestore.collection(collectionName).get();
      return snapshot.docs;
    } catch (e) {
      throw Exception('Failed to get collection: $e');
    }
  }

  @override
  Future<void> setDocument(Map<String, dynamic> data) async {
    try {
      await _firestore.doc(collectionName).set(data);
    } catch (e) {
      throw Exception('Failed to set document: $e');
    }
  }

  @override
  Future<void> updateDocument(Map<String, dynamic> data, {Eq? eq}) async {
    try {
      await _firestore.doc(collectionName).update(data);
    } catch (e) {
      throw Exception('Failed to update document: $e');
    }
  }

  @override
  Future<void> deleteDocument() async {
    try {
      await _firestore.doc(collectionName).delete();
    } catch (e) {
      throw Exception('Failed to delete document: $e');
    }
  }
}

class SupabaseService implements DatabaseService {
  final String collectionName;
  SupabaseService({
    required this.collectionName,
  });
  final instance = Supabase.instance.client;

  @override
  Future<dynamic> getDocument({Eq? eq}) async {
    try {
      if (eq != null) {
        final response = await instance
            .from(collectionName)
            .select()
            .eq(eq.column, eq.value)
            .single();
        final Map<String, dynamic> data = response;
        return data;
      } else {
        final response = await instance.from(collectionName).select().single();
        final Map<String, dynamic> data = response;
        return data;
      }
    } catch (_) {}
  }

  @override
  Future<dynamic> getCollection() async {
    try {
      final response = await instance.from('countries').select();
      final List<dynamic> dataList = response;
      return dataList;
    } catch (_) {}
  }

  @override
  Future<void> setDocument(Map<String, dynamic> data) async {
    try {
      await instance.from(collectionName).upsert(data);
    } catch (_) {}
  }

  @override
  Future<void> updateDocument(Map<String, dynamic> data, {Eq? eq}) async {
    try {
      if (eq != null) {
        await instance.from('countries').update(data).eq(eq.column, eq.value);
      } else {
        await instance.from('countries').update(data);
      }
    } catch (_) {}
  }

  @override
  Future<void> deleteDocument() async {
    try {
      await instance.from(collectionName).delete().neq('id', collectionName);
    } catch (_) {}
  }
}

class Database {
  final DatabaseService _service;
  final String collectionName;

  Database({required this.collectionName, required bool useFirestore})
      : _service = useFirestore
            ? FirestoreService(collectionName: collectionName)
            : SupabaseService(collectionName: collectionName);

  ///Returns a single document from a collection stored in [Supabase] or [FirebaseFirestore],
  ///
  ///Required [collectionName] and an Object of [Eq] for applying filters
  Future<dynamic> getDocument({Eq? eq}) => _service.getDocument();

  ///Returns all documents from [Supabase] or [FirebaseFirestore],
  ///
  ///Required [collectionName]
  Future<dynamic> getCollection() => _service.getCollection();

  ///
  Future<void> setDocument(Map<String, dynamic> data) =>
      _service.setDocument(data);

  ///
  Future<void> updateDocument(Map<String, dynamic> data) =>
      _service.updateDocument(data);

  ///
  Future<void> deleteDocument() => _service.deleteDocument();
}

class Eq {
  final String column;
  final Object value;

  Eq({required this.column, required this.value});
}

class Neq {
  final String column;
  final Object value;

  Neq({required this.column, required this.value});
}
