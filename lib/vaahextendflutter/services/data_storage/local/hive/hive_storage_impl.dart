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
  Future<void> create({dynamic key, dynamic value}) async {
    if (_box != null) {
      if (key == null && value is Map<String, String>) {
        _box!.putAll(value);
      } else if (key is String && value is String) {
        _box!.put(key, value);
      } else {
        throw ArgumentError(
          'To save a single entry, the key and the value must be of type String,'
          'To save multiple entries pass only the value as Map<Sring, String>',
        );
      }
    } else {
      throw Exception('Box is null, not initialized.');
    }
  }

  @override
  Future<dynamic> update({dynamic key, dynamic value}) {
    create(key: key, value: value);
    return read(key: key);
  }

  @override
  Future<dynamic> read({dynamic key}) async {
    if (_box != null) {
      if (key is String) {
        if (_box!.containsKey(key)) {
          String result = await _box!.get(key);
          return result;
        }
      } else if (key is List<String>) {
        Map<String, String> result = {};
        for (String k in key) {
          result[k] = (_box!.get(k));
        }
        return result;
      } else if (key == null) {
        Map<dynamic, dynamic> result = _box!.toMap();
        return result;
      } else {
        throw ArgumentError('key must be of type String or List<String>');
      }
    } else {
      throw Exception('Box is null, not initiized.');
    }
  }

  @override
  void delete({dynamic key}) async {
    if (_box != null) {
      if (key is String) {
        if (_box!.containsKey(key)) {
          await _box!.delete(key);
        }
      } else if (key is List<String>) {
        _box!.deleteAll(key);
      } else if (key == null) {
        await _box!.clear();
      } else {
        throw ArgumentError('key must be of type String or List<String>');
      }
    } else {
      throw Exception('Box is null, not initiized.');
    }
  }
}
