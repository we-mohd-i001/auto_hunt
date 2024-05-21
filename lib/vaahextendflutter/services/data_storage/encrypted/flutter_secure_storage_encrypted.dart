import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

import '../storage.dart';

class FlutterSecureStorageEncryptedImpl implements Storage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  encrypt.Key? key;
  encrypt.IV? iv;
  encrypt.Encrypter? encrypter;

  @override
  Future<void> init() async {
    key = encrypt.Key.fromUtf8('athirtytwocharacterslongstring00');
    iv = encrypt.IV.fromLength(16);
    encrypter = encrypt.Encrypter(encrypt.AES(key!));
  }

  @override
  Future<void> create({required String key, required String value}) async {
    assert(encrypter != null, 'Encrypter was not initialized.');
    final String encryptedValue = encrypter!.encrypt(value, iv: iv).base64;
    await _storage.write(key: key, value: encryptedValue);
  }

  @override
  Future<void> createAll({required Map<String, String> values}) async {
    assert(encrypter != null, 'Encrypter was not initialized.');
    for (MapEntry<String, String> entry in values.entries) {
      final String encryptedValue = encrypter!.encrypt(entry.value, iv: iv).base64;
      await _storage.write(key: entry.key, value: encryptedValue);
    }
  }

  @override
  Future<String?> read({required String key}) async {
    final String? encryptedValue = await _storage.read(key: key);
    if (encryptedValue == null) return null;
    assert(encrypter != null, 'Encrypter was not initialized.');
    final String decryptedValue = encrypter!.decrypt64(encryptedValue, iv: iv);
    return decryptedValue;
  }

  @override
  Future<Map<String, String?>> readAll({List<String>? keys}) async {
    assert(encrypter != null, 'Encrypter was not initialized.');
    final Map<String, String?> result = {};
    if (keys != null) {
      for (String k in keys) {
        final String? encryptedValue = await _storage.read(key: k);
        result[k] = encryptedValue == null ? null : encrypter!.decrypt64(encryptedValue, iv: iv);
      }
    } else {
      final Map<String, String> encryptedResult = await _storage.readAll();
      for (MapEntry<String, String> entry in encryptedResult.entries) {
        result[entry.key] = encrypter!.decrypt64(entry.value, iv: iv);
      }
    }
    return result;
  }

  @override
  Future<void> delete({dynamic key}) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll({List<String>? keys}) async {
    if (keys is List<String>) {
      for (String k in keys) {
        await _storage.delete(key: k);
      }
    } else if (keys == null) {
      await _storage.deleteAll();
    }
  }
}
