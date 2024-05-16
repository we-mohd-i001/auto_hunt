import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../storage.dart';

class FlutterSecureStorageImpl implements Storage {
  final _storage = const FlutterSecureStorage();
  @override
  Future<void> init() async {}

  @override
  Future<void> create({dynamic key, dynamic value}) async {
    if (key == null && value is Map<String, String>) {
      for (String k in value.keys) {
        await _storage.write(key: k, value: value[k]);
      }
    } else if (key is String && value is String) {
      await _storage.write(key: key, value: value);
    } else {
      throw ArgumentError(
        'To save a single entry, the key and the value must be of type String,'
        'To save multiple entries pass only the value as Map<Sring, String>',
      );
    }
  }

  @override
  Future<dynamic> read({dynamic key}) async {
    if (key is String) {
      String? result = await _storage.read(key: key);
      return result;
    } else if (key is List<String>) {
      Map<String, dynamic> result = {};
      for (String k in key) {
        result[k] = await _storage.read(key: k);
      }
      return result;
    } else if (key == null) {
      Map<String, String> result = await _storage.readAll();
      return result;
    } else {
      throw ArgumentError('key must be of type String or List<String>');
    }
  }

  @override
  Future<dynamic> update({dynamic key, dynamic value}) {
    create(key: key, value: value);
    return read(key: key);
  }

  @override
  void delete({dynamic key}) async {
    if (key is String) {
      await _storage.delete(key: key);
    } else if (key is List<String>) {
      for (String k in key) {
        await _storage.delete(key: k);
      }
    } else if (key == null) {
      await _storage.deleteAll();
    } else {
      throw ArgumentError(
        'key must be of type String or List<String>',
      );
    }
  }
}
