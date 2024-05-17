import 'package:hive/hive.dart';

import '../../storage.dart';

/// A class implementing Storage interface using Hive as storage backend.
class HiveStorageImpl implements Storage {
  final String name;
  HiveCipher? encryptionCypher;
  Box? _box;
  HiveStorageImpl({
    required this.name,
    this.encryptionCypher,
  });

  @override
  Future<void> init() async {
    _box = await Hive.openBox(
      name,
      encryptionCipher: encryptionCypher,
    );
  }

  @override
  Future<void> create({required String key, required String value}) async {
    if (_box != null) {
      _box!.put(key, value);
    } else {
      throw Exception('Box is null, not initialized.');
    }
  }

  @override
  Future<void> createAll({required Map<String, String> values}) async {
    if (_box != null) {
      for (String k in values.keys) {
        await _box!.put(k, values[k]);
      }
    } else {
      throw Exception('Box is null, not initialized.');
    }
  }

  @override
  Future<String?> read({required String key}) async {
    if (_box != null) {
      String? result = await _box!.get(key);
      return result;
    } else {
      throw Exception('Box is null, not initiized.');
    }
  }

  @override
  Future<Map<String, String?>> readAll({List<String>? keys}) async {
    if (_box != null) {
      if (keys is List<String>) {
        Map<String, String> result = {};
        for (String k in keys) {
          result[k] = await _box!.get(k);
        }
        return result;
      } else {
        final result = _box!.toMap() as Map<String, String?>;
        return result;
      }
    } else {
      throw Exception('Box is null, not initiized.');
    }
  }

  @override
  Future<void> delete({dynamic key}) async {
    if (_box != null) {
      await _box!.delete(key);
    } else {
      throw Exception('Box is null, not initiized.');
    }
  }

  @override
  Future<void> deleteAll({List<String>? keys}) async {
    if (_box != null) {
      if (keys is List<String>) {
        _box!.deleteAll(keys);
      } else {
        await _box!.clear();
      }
    } else {
      throw Exception('Box is null, not initiized.');
    }
  }
}
