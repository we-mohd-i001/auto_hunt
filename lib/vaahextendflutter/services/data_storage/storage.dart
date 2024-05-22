import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../env.dart';
import 'encrypted/flutter_secure_storage_encrypted.dart';
import 'encrypted/hive_encrypted_data_storage.dart';
import 'local/flutter_secure_storage/flutter_secure_storage_impl.dart';
import 'local/hive/hive_storage_impl.dart';
import 'network/firebase/firestore_storage_impl.dart';
import 'network/helpers/filter.dart';

abstract class Storage {
  static final EnvironmentConfig _envConfig = EnvironmentConfig.getEnvConfig();

  ///Creates a new Local Storage [HiveStorageImpl] or [FlutterSecureStorageImpl]
  ///
  ///The argument [name] is used to open Hive box with that name.
  ///
  ///If you don't provide [name], 'default' will be used.
  factory Storage.createLocal({String name = 'default'}) {
    switch (_envConfig.localStorageType) {
      case LocalStorageType.hive:
        final hive = HiveStorageImpl(name: name);
        hive.init();
        return hive;
      case LocalStorageType.flutterSecureStorage:
        return FlutterSecureStorageImpl();
      default:
        return NullStorage();
    }
  }

  ///Creates a new Network Storage [FirestoreStorageImpl] or [SupabaseImpl]
  factory Storage.createNetwork({String name = 'default'}) {
    switch (_envConfig.networkStorageType) {
      case NetworkStorageType.firebase:
        final firestore = FirestoreStorageImpl(collectionName: name);
        firestore.init();
        return NullStorage();
      case NetworkStorageType.supabase:
        return NullStorage();
      case NetworkStorageType.none:
        return NullStorage();
    }
  }

  ///Creates a new Encrypted Local Storage [HiveEncryptedStorage] or [FlutterSecureStorageEncryptedImpl]
  factory Storage.createEncryptedLocal({String name = 'default'}) {
    switch (_envConfig.localStorageType) {
      case LocalStorageType.hive:
        final hive = HiveEncryptedStorage(name: name);
        return hive;
      case LocalStorageType.flutterSecureStorage:
        return FlutterSecureStorageEncryptedImpl();
      default:
        return NullStorage();
    }
  }

  Storage();

  ///Initializes the [Storage].
  ///In the case of [HiveStorageImpl], it creates a [Directory] using the path_provide package,
  ///initializes hive at that directory and opens a box with name [name] provided
  ///during [Storage] creation.
  ///In case of encrypted storages it initializes the encryption tecniques.
  ///It's not required in the case of [FlutterSecureStorageImpl].
  /// example:
  ///```dart
  /// Storage.createLocal('name')
  /// ```
  Future<void> init();

  ///Creates or updates new item in the database.
  ///
  ///To save or update as a single key-value pair pass [key] as String, and the [value] as String, the String
  ///could be a JSON String or a simple text according to your requirement.
  ///If the key is already present in the [Storage] it's vlaue will be overwritten.
  ///```dart
  ///await storage.create(key: 'key', value: 'value');
  /// ```
  Future<void> create({required String key, required String value});

  ///Creates new items in the database.
  ///If you want to save multiple data pass the value as Map<String, String>, then it will save all
  ///the key-value pairs in the [values] map.
  ///If any key fromthe [values] is already present in the [Storage] it's vlaue will be overwritten.
  ///```dart
  ///await storage.createAll(values: {
  ///   'key1': 'Value1',
  ///   'key2': 'Value2',
  ///   'key3': 'Value3',
  ///   'key4': 'Value4',
  ///   'key5': 'Value5',
  ///   //...
  ///   },
  /// );
  /// ```
  Future<void> createAll({required Map<String, String> values});

  ///Reads the value of the item at [key] from the [Storage] and returns the value.
  ///
  ///Read a single value by passing [key] as String, it will return the value as String.
  ///```dart
  ///await storage.read(key: 'key');
  ///```
  Future<String?> read({required String key});

  ///Reads multiple values, pass the List of [keys] as argument. It will return the value as
  ///Map<String, String?>.
  ///
  ///When the keys is not passed it will return all the values from that [Storage] as
  ///Map<String, String?>
  ///```dart
  ///await storage.readAll(keys: [
  ///   'key1',
  ///   'key2',
  ///   //...
  ///  ],
  ///);
  ///```
  Future<Map<String, String?>> readAll({List<String> keys = const []});

  ///Deletes an item at [key].
  ///```dart
  ///await storage.delete(key: 'key');
  ///```
  Future<void> delete({required String key});

  ///Deletes item at a key present in [keys], if keys is not passed all the values will be deleted
  ///from that [Storage].
  ///```dart
  ///await storage.deleteAll(keys: [
  ///   'key1',
  ///   'key2',
  ///   //...
  ///  ],
  ///);
  ///```
  Future<void> deleteAll({List<String> keys = const []});
}

abstract class NetworkStorage extends Storage {}

class SupabaseImpl implements NetworkStorage {
  final instance = Supabase.instance.client;

  @override
  Future<void> create({String? key, String? value}) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> createAll({Map<String, String>? values}) {
    // TODO: implement createAll
    throw UnimplementedError();
  }

  @override
  Future<void> delete({String? key}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll({List<String>? keys}) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<String?> read({String? key}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String?>> readAll({List<String>? keys}) {
    // TODO: implement readAll
    throw UnimplementedError();
  }
}

class NullStorage implements Storage {
  @override
  Future<void> create({required String key, required String value}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> createAll({Map<String, String>? values}) {
    // TODO: implement createAll
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String key}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll({List<String>? keys}) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<String> read({required String key}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String?>> readAll({List<String>? keys}) {
    // TODO: implement readAll
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
  Future<dynamic> getDocument({required Filter filter});
  Future<dynamic> getCollection({Filter? filter});
  Future<void> setDocument(Map<String, dynamic> data, {String? onConflict});
  Future<void> updateDocument(Map<String, dynamic> data, {Filter? filter});
  Future<void> deleteDocument({Filter? filter});
}

class FirestoreService implements DatabaseService {
  final String collectionName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirestoreService({required this.collectionName});

  @override
  Future<dynamic> getDocument({required Filter filter}) async {
    try {
      final snapshot = await _firestore.doc(collectionName).get();
      return snapshot;
    } catch (e) {
      throw Exception('Failed to get document: $e');
    }
  }

  @override
  Future<List<dynamic>> getCollection({Filter? filter}) async {
    try {
      if (filter != null) {
        final snapshot = await _firestore
            .collection(collectionName)
            .where(filter.column, isEqualTo: filter.value)
            .get();
        return snapshot.docs;
        // }
        // else if (eq == null && neq != null) {
        //   final snapshot = await _firestore
        //       .collection(collectionName)
        //       .where(neq.column, isEqualTo: neq.value)
        //       .get();
        //   return snapshot.docs;
        // }
        // //when both eq and neq are provided (not null)
        // else if (eq != null && neq != null) {
        //   if (eq.column != neq.column) {
        //     final snapshot = await _firestore
        //         .collection(collectionName)
        //         .where(eq.column, isEqualTo: eq.value, isNotEqualTo: neq..value)
        //         .get();
        //     return snapshot.docs;
        //   } else {
        //     throw ArgumentError();
        // }
      } else {
        final snapshot = await _firestore.collection(collectionName).get();
        return snapshot.docs;
      }
    } on ArgumentError {
      throw ArgumentError('Eq.column should be equal to Neq.column');
    } catch (e) {
      throw Exception('Failed to get collection: $e');
    }
  }

  @override
  Future<void> setDocument(Map<String, dynamic> data, {String? onConflict}) async {
    try {
      await _firestore.doc(collectionName).set(data);
    } catch (e) {
      throw Exception('Failed to set document: $e');
    }
  }

  @override
  Future<void> updateDocument(Map<String, dynamic> data, {Filter? filter}) async {
    try {
      await _firestore.doc(collectionName).update(data);
    } catch (e) {
      throw Exception('Failed to update document: $e');
    }
  }

  @override
  Future<void> deleteDocument({Filter? filter}) async {
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
  Future<dynamic> getDocument({required Filter filter}) async {
    try {
      final response = await instance
          .from(collectionName)
          .select()
          .filter(
            filter.column,
            operatorToString(filter.operator),
            filter.value,
          )
          .single();
      final Map<String, dynamic> document = response;
      return document;
    } catch (e) {
      throw Exception('''$e'''
          ''' Possible Reason : The document(column: ${filter.column}, value: ${filter.value}) you queried for might not exists in the Database.''');
    }
  }

  @override
  Future<dynamic> getCollection({Filter? filter}) async {
    try {
      final query = instance.from(collectionName);
      //when only eq is provided
      if (filter != null) {
        final response = await query
            .select()
            .filter(
              filter.column,
              operatorToString(filter.operator),
              filter.value,
            )
            .filter(
              filter.column,
              operatorToString(filter.operator),
              filter.value,
            );

        final List<dynamic> dataList = response;
        return dataList;
        // }
        // //when eq is null but neq is provided
        // else if (eq == null && neq != null) {
        //   final response = await query.select().neq(neq.column, neq.value);
        //   final List<dynamic> dataList = response;
        //   return dataList;
        // }
        // //when both eq and neq are provided (not null)
        // else if (eq != null && neq != null) {
        //   final response = await query
        //       .select()
        //       .eq(eq.column, eq.value)
        //       .neq(neq.column, neq.value);
        //   final List<dynamic> dataList = response;
        //   return dataList;
      } else {
        final response = await query.select();
        final List<dynamic> dataList = response;
        return dataList;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> setDocument(Map<String, dynamic> data, {String? onConflict}) async {
    try {
      final query = instance.from(collectionName);
      await query.upsert(data, onConflict: onConflict);
    } catch (_) {}
  }

  @override
  Future<void> updateDocument(Map<String, dynamic> data, {Filter? filter}) async {
    try {
      final query = instance.from(collectionName);
      if (filter != null) {
        await query.update(data).filter(
              filter.column,
              operatorToString(filter.operator),
              filter.value,
            );
      }

      // //only eq is provided
      // if (eq != null && neq == null) {
      //   await query.update(data).eq(eq.column, eq.value);
      // }
      // //only neq is provided
      // else if (eq == null && neq != null) {
      //   await query.update(data).neq(neq.column, neq.value);
      // }
      // //when both eq and neq are not null
      // else if (eq != null && neq != null) {
      //   await query
      //       .update(data)
      //       .neq(neq.column, neq.value)
      //       .eq(eq.column, eq.value);
      // } else {
      //   throw ArgumentError();
      // }
    } on ArgumentError {
      throw ArgumentError('Both eq and neq can not be null at the same time.');
    } catch (_) {}
  }

  @override
  Future<void> deleteDocument({Filter? filter}) async {
    try {
      final query = instance.from(collectionName);
      if (filter != null) {
        await query.delete().match({}).filter(
          filter.column,
          operatorToString(filter.operator),
          filter.value,
        );
      }
      // if (eq != null && neq == null) {
      //   await query.delete().eq(eq.column, eq.value);
      // } else if (neq != null && eq == null) {
      //   await query.delete().neq(neq.column, neq.value);
      // } else if (eq != null && neq != null) {
      //   await query.delete().neq(neq.column, neq.value).eq(eq.column, eq.value);
      // } else {
      //   throw ArgumentError();
      // }
    } on ArgumentError {
      throw ArgumentError('Both eq and neq can not be null at the same time.');
    } catch (_) {}
  }
}

class Database {
  final DatabaseService _service;
  final String collectionName;

  ///Creates a new Storage object for either [FirebaseFirestore] or [Supabase]
  ///
  ///Example:
  /// ```dart
  /// import 'path/to/storage.dart.dart';
  /// // ...
  ///
  /// final db = Database(useFirestore: false, collectionName: 'countries');
  ///
  /// ```
  Database({required this.collectionName, required bool useFirestore})
      : _service = useFirestore
            ? FirestoreService(collectionName: collectionName)
            : SupabaseService(collectionName: collectionName);

  ///Returns a single document from a collection stored in [Supabase] or [FirebaseFirestore],
  ///
  ///Required String [collectionName] and an optional Object [eq] of [Eq] for applying filters
  Future<dynamic> getDocument({required Filter filter}) => _service.getDocument(filter: filter);

  ///Returns all documents of collection stored in [Supabase] or [FirebaseFirestore].
  ///If eq and neq are provided the it will return a filtered List of documents.
  Future<dynamic> getCollection({Filter? filter}) => _service.getCollection(filter: filter);

  ///Insert a document [document] in collerction [collectionName]
  Future<void> setDocument(Map<String, dynamic> document, {String? onConflict}) =>
      _service.setDocument(document, onConflict: onConflict);

  ///Updates a given document in collerction [collectionName]
  Future<void> updateDocument(Map<String, dynamic> document, {Filter? filter}) =>
      _service.updateDocument(document, filter: filter);

  ///Deletes document from collection [collectionName]
  Future<void> deleteDocument({Filter? filter}) => _service.deleteDocument(filter: filter);
}

class Filter {
  final String column;
  final Operator operator; //make operator an enum
  final Object? value;

  Filter({required this.column, required this.operator, required this.value});
}

enum Operator {
  eq,
  neq,
  gt,
  gte,
  lt,
  lte,
  like,
}

String operatorToString(Operator operator) {
  switch (operator) {
    case Operator.eq:
      return 'eq';
    case Operator.neq:
      return 'neq';
    case Operator.gt:
      return 'gt';
    case Operator.gte:
      return 'gte';
    case Operator.lt:
      return 'lt';
    case Operator.lte:
      return 'lte';
    case Operator.like:
      return 'like';
  }
}
