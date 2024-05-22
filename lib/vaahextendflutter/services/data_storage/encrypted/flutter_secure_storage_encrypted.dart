import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../../../../helpers/commons.dart';
import '../storage.dart';

//TODO: Remove all print statements.

class FlutterSecureStorageEncryptedImpl implements Storage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  encrypt.Key? encryptionKey;
  encrypt.IV? iv;
  encrypt.Encrypter? encrypter;
  final String vaahFlutterIv = 'vaahflutteriv';

  @override
  Future<void> init() async {
    encryptionKey = encrypt.Key.fromUtf8('athirtytwocharacterslongstring00');
    final String? ivString = await _storage.read(key: vaahFlutterIv);
    if (ivString == null) {
      iv = encrypt.IV.fromLength(16);
      await _storage.write(key: vaahFlutterIv, value: base64Url.encode(iv!.bytes));
    } else {
      iv = encrypt.IV(base64Url.decode(ivString));
    }
    encrypter = encrypt.Encrypter(encrypt.AES(encryptionKey!));
  }

  @override
  Future<void> create({required String key, required String value}) async {
    assert(encrypter != null, 'Encrypter was not initialized.');
    final String encryptedValue = _encrypt(value: value, iv: iv);
    smartPrint(encryptedValue);
    await _storage.write(key: key, value: encryptedValue);
  }

  @override
  Future<void> createAll({required Map<String, String> values}) async {
    assert(encrypter != null, 'Encrypter was not initialized.');
    for (MapEntry<String, String> entry in values.entries) {
      assert(entry.key != vaahFlutterIv);
      final String encryptedValue = _encrypt(value: entry.value, iv: iv);
      smartPrint(encryptedValue);
      await _storage.write(key: entry.key, value: encryptedValue);
    }
  }

  @override
  Future<String?> read({required String key}) async {
    final String? encryptedValue = await _storage.read(key: key);
    smartPrint('read fsse enc -> $encryptedValue');
    if (encryptedValue == null) return null;
    assert(encrypter != null, 'Encrypter was not initialized.');
    final String decryptedValue = encrypter!.decrypt64(encryptedValue, iv: iv);
    smartPrint('read fsse dec -> $decryptedValue');
    return decryptedValue;
  }

  @override
  Future<Map<String, String?>> readAll({List<String> keys = const []}) async {
    assert(encrypter != null, 'Encrypter was not initialized.');
    assert(!keys.contains(vaahFlutterIv));
    final Map<String, String?> result = {};
    if (keys.isEmpty) {
      final Map<String, String> encryptedResult = await _storage.readAll();
      smartPrint('readAll(null) fsse enc -> $encryptedResult');
      for (MapEntry<String, String> entry in encryptedResult.entries) {
        if (entry.key != vaahFlutterIv) {
          result[entry.key] = _decrypt(iv: iv, encryptedValue: entry.value);
        }
      }
    } else {
      for (String k in keys) {
        final String? encryptedValue = await _storage.read(key: k);
        smartPrint('readAll(List) fsse enc -> $encryptedValue');
        result[k] =
            encryptedValue == null ? null : _decrypt(iv: iv, encryptedValue: encryptedValue);
      }
    }
    smartPrint('readAll fsse dec -> $result');
    return result;
  }

  @override
  Future<void> delete({required String key}) async {
    assert(key != vaahFlutterIv);
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll({List<String> keys = const []}) async {
    if (keys.isEmpty) {
      await _storage.deleteAll();
    } else {
      for (String k in keys) {
        await _storage.delete(key: k);
      }
    }
  }

  String _encrypt({required String value, required encrypt.IV? iv}) {
    final String encryptedValue = encrypter!.encrypt(value, iv: iv).base64;
    return encryptedValue;
  }

  String _decrypt({required String encryptedValue, required encrypt.IV? iv}) {
    final String decryptedValue = encrypter!.decrypt64(encryptedValue, iv: iv);
    return decryptedValue;
  }
}
