import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yourtasks/vaahextendflutter/services/storage/network/storage.dart';

import 'base_service.dart';

class NetworkStorageWithSupabase implements NetworkStorageService {
  final supabase = Supabase.instance.client;

  @override
  Future<void> create({
    required String collectionName,
    required String key,
    required Map<String, dynamic> value,
  }) async {
    try {
      value['key'] = key;
      await supabase.from(collectionName).insert(value);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> createMany({
    required String collectionName,
    required Map<String, Map<String, dynamic>> values,
  }) async {
    List<Map<String, dynamic>> valuesMapToList = [];
    values.forEach((key, value) {
      Map<String, dynamic> entry = Map<String, dynamic>.from(value);
      entry['key'] = key;
      valuesMapToList.add(entry);
    });
    await supabase.from(collectionName).insert(valuesMapToList);
  }

  @override
  GetData read({required String collectionName, required String key}) {
    final GetData getData = GetSupabaseData(collectionName: collectionName, key: key);
    return getData;
  }

  @override
  Future<Map<String, GetData>> readMany(
      {required String collectionName, List<String> keys = const []}) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Map<String, dynamic>?>> readAll({required String collectionName}) async {
    try {
      final listResult = await supabase.from(collectionName).select();
      Map<String, Map<String, dynamic>> result = {};

      for (Map<String, dynamic> item in listResult) {
        String key = item['key'];

        Map<String, dynamic> entry = Map<String, dynamic>.from(item);
        entry.remove('key');

        result[key] = entry;
      }
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> update({
    required String collectionName,
    required String key,
    required Map<String, dynamic> value,
  }) async {
    try {
      await supabase.from(collectionName).update(value).eq('key', key);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateMany({
    required String collectionName,
    required Map<String, Map<String, dynamic>> values,
  }) async {
    values.forEach((key, value) async {
      await update(collectionName: collectionName, key: key, value: value);
    });
  }

  @override
  Future<void> createOrUpdate({
    required String collectionName,
    required String key,
    required Map<String, dynamic> value,
  }) async {
    try {
      value['key'] = key;
      await supabase.from(collectionName).upsert(value);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> createOrUpdateMany({
    required String collectionName,
    required Map<String, Map<String, dynamic>> values,
  }) async {
    values.forEach((key, value) async {
      await createOrUpdate(collectionName: collectionName, key: key, value: value);
    });
  }

  @override
  Future<void> delete({required String collectionName, required String key}) async {
    await supabase.from(collectionName).delete().eq('key', key);
  }

  @override
  Future<void> deleteMany({required String collectionName, required List<String> keys}) async {
    await supabase.from(collectionName).delete().inFilter('key', keys);
  }

  @override
  Future<void> deleteAll({required String collectionName}) async {
    await supabase.from(collectionName).delete().neq('key', '');
  }
}
