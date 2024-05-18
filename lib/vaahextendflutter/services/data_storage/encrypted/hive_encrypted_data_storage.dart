import 'dart:convert';

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
    final encryptedKey = await _getEncryptionKeyFromString(name);
    final encryptionKeyUint8List = base64Url.decode(encryptedKey!);
    _encryptedBox =
        await Hive.openBox(name, encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  }

  @override
  Future<void> create({required String key, required String value}) async {
    _encryptedBox!.put(key, value);
    print(_encryptedBox!.get('secret'));
  }

  @override
  Future<void> createAll({required Map<String, String> values}) {
    // TODO: implement createAll
    throw UnimplementedError();
  }

  @override
  Future<String?> read({required String key}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String?>> readAll({List<String>? keys}) {
    // TODO: implement readAll
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

  Future<String?> _getEncryptionKeyFromString(String key) async {
    final encryptionKeyString = await _secureStorage.read(key: key);
    if (encryptionKeyString == null) {
      final hiveKey = Hive.generateSecureKey();
      await _secureStorage.write(
        key: key,
        value: base64UrlEncode(hiveKey),
      );
    }
    final secureKey = await _secureStorage.read(key: key);
    return secureKey;
  }
}
