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


