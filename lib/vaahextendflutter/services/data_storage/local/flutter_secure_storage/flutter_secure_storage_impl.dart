import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../storage.dart';

class FlutterSecureStorageImpl implements Storage {
  final storage = const FlutterSecureStorage();
  @override
  Future<void> init() async {}

  @override
  Future<void> create({dynamic key, dynamic value}) async {
    if (key == null && value is Map<String, String>) {
      for (String k in value.keys) {
        await storage.write(key: k, value: value[k]);
      }
    } else if (key is String && value is String) {
      await storage.write(key: key, value: value);
    } else {
      throw ArgumentError('To save a single entry key and value must be of type String',
          'To save multiple entries only provide value as Map<Sring, String>, ');
    }
  }

  @override
  Future<dynamic> read({dynamic key}) async {
    if (key is String) {
      String? result = await storage.read(key: key);
      return result;
    } else if (key is List<String>) {
      List<dynamic> result = [];
      for (String k in key) {
        result.add(await storage.read(key: k));
      }
      return result;
    } else if (key == null) {
      Map<String, String> result = await storage.readAll();
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
      await storage.delete(key: key);
    } else if (key is List<String>) {
      for (String k in key) {
        await storage.delete(key: k);
      }
    } else if (key == null) {
      await storage.deleteAll();
    } else {
      throw ArgumentError(
        'key must be of type String or List<String>',
      );
    }
  }
}
