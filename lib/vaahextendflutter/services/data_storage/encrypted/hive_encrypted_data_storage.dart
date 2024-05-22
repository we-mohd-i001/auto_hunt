import 'dart:convert';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../storage.dart';

class HiveEncryptedStorage implements Storage {
  final String name;
  HiveEncryptedStorage({this.name = 'default'});

  Box? _encryptedBox;
  final _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> init() async {
    final Uint8List encryptedBoxKey = await _getEncryptionKeyFromString(name);
    _encryptedBox = await Hive.openBox(name, encryptionCipher: HiveAesCipher(encryptedBoxKey));
  }

  @override
  Future<void> create({required String key, required String value}) async {
    assert(_encryptedBox != null);
    _encryptedBox!.put(key, value);
  }

  @override
  Future<void> createAll({required Map<String, String> values}) async {
    assert(_encryptedBox != null);
    for (String k in values.keys) {
      await _encryptedBox!.put(k, values[k]);
    }
  }

  @override
  Future<String?> read({required String key}) async {
    assert(_encryptedBox != null);
    String? result = _encryptedBox!.get(key);
    return result;
  }

  @override
  Future<Map<String, String?>> readAll({List<String> keys = const []}) async {
    assert(_encryptedBox != null);
    if (keys.isEmpty) {
      Map<String, String?> result =
          _encryptedBox!.toMap().map((key, value) => MapEntry(key.toString(), value?.toString()));
      return result;
    } else {
      Map<String, String?> result = {};
      for (String k in keys) {
        result[k] = _encryptedBox!.get(k);
      }
      return result;
    }
  }

  @override
  Future<void> delete({dynamic key}) async {
    assert(_encryptedBox != null);
    await _encryptedBox!.delete(key);
  }

  @override
  Future<void> deleteAll({List<String> keys = const []}) async {
    assert(_encryptedBox != null);
    if (keys.isEmpty) {
      await _encryptedBox!.clear();
    } else {
      _encryptedBox!.deleteAll(keys);
    }
  }

  Future<Uint8List> _getEncryptionKeyFromString(String key) async {
    final encryptionKeyString = await _secureStorage.read(key: key);
    if (encryptionKeyString == null) {
      final hiveKey = Hive.generateSecureKey();
      await _secureStorage.write(
        key: key,
        value: base64UrlEncode(hiveKey),
      );
    }
    final secureKey = await _secureStorage.read(key: key);
    final encryptionKeyUint8List = base64Url.decode(secureKey!);
    return encryptionKeyUint8List;
  }
}
