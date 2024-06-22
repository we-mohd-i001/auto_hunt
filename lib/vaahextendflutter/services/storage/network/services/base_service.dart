import 'package:yourtasks/vaahextendflutter/services/storage/network/storage.dart';

abstract class NetworkStorageService {
  Future<void> create(
      {required String collectionName, required String key, required Map<String, dynamic> value});

  Future<void> createMany({
    required String collectionName,
    required Map<String, Map<String, dynamic>> values,
  });

  GetData read({required String collectionName, required String key});

  Future<Map<String, GetData>> readMany({
    required String collectionName,
    List<String> keys = const [],
  });

  Future<Map<String, Map<String, dynamic>?>> readAll({required String collectionName});

  Future<void> update({
    required String collectionName,
    required String key,
    required Map<String, dynamic> value,
  });

  Future<void> updateMany({
    required String collectionName,
    required Map<String, Map<String, dynamic>> values,
  });

  Future<void> createOrUpdate({
    required String collectionName,
    required String key,
    required Map<String, dynamic> value,
  });

  Future<void> createOrUpdateMany({
    required String collectionName,
    required Map<String, Map<String, dynamic>> values,
  });

  Future<void> delete({required String collectionName, required String key});

  Future<void> deleteMany({required String collectionName, required List<String> keys});

  Future<void> deleteAll({required String collectionName});
}
