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
    assert(_box != null);
    if (_box != null) {
      if (value is Map<String, String>) {
        _box!.putAll(value);
      } else if ((value is List<String>) && (key is List<String>)) {
        for (int i = 0; i < key.length; i++) {
          _box!.put(key[i], value[i]);
        }
      } else if (key is String && value is String) {
        if (!_box!.containsKey(key)) {
          _box!.put(key, value);
        } else {
          _box!.put(key, value);
        }
      } else {
        throw ArgumentError(
            'key must be String or List<String>, data must be String, List<String>, or Map<String, String>');
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
    dynamic value;
    if (_box != null) {
      if (key is List<String>) {
        value = List<dynamic>.empty(growable: true);
        for (int i = 0; i < key.length; i++) {
          value.add((_box!.get(key[i])));
        }
        return value;
      } else if (key is String) {
        if (_box!.containsKey(key)) {
          value = await _box!.get(key);
          return value;
        }
      } else if (key == null) {
        value = _box!.toMap();
        return value;
      } else {
        throw ArgumentError('key must be of type String or List<String>');
      }
    } else {
      throw Exception('Box is null, not initiized.');
    }
    return value;
  }

  @override
  void delete({dynamic key}) async {
    if (_box != null) {
      if (key is List<String>) {
        _box!.deleteAll(key);
      } else if (key is String) {
        if (_box!.containsKey(key)) {
          await _box!.delete(key);
        }
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
