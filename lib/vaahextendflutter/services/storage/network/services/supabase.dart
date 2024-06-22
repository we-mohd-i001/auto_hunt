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
  Future<void> createMany(
      {String collectionName = '', required Map<String, Map<String, dynamic>> values}) {
    // TODO: implement createAll
    throw UnimplementedError();
  }

  @override
  GetData read({String collectionName = '', required String key}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Map<String, GetData>> readMany(
      {required String collectionName, List<String> keys = const []}) {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<Map<String, Map<String, dynamic>?>> readAll({required String collectionName}) {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<void> update({
    required String collectionName,
    required String key,
    required Map<String, dynamic> value,
  }) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> updateMany({
    required String collectionName,
    required Map<String, Map<String, dynamic>> values,
  }) {
    // TODO: implement updateMany
    throw UnimplementedError();
  }

  @override
  Future<void> createOrUpdate(
      {required String collectionName, required String key, required Map<String, dynamic> value}) {
    // TODO: implement createOrUpdate
    throw UnimplementedError();
  }

  @override
  Future<void> createOrUpdateMany({
    required String collectionName,
    required Map<String, Map<String, dynamic>> values,
  }) {
    // TODO: implement createOrUpdateMany
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String collectionName, required String key}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteMany({required String collectionName, required List<String> keys}) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll({required String collectionName}) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }
}
