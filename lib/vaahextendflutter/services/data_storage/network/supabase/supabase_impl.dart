import 'package:supabase_flutter/supabase_flutter.dart';

import '../../storage.dart';

class SupabaseImpl implements Storage {
  final String collectionName;

  SupabaseImpl({
    required this.collectionName,
  });

  final SupabaseClient _instance = Supabase.instance.client;

  @override
  Future<void> init() async {}

  @override
  Future<void> create({required String key, required String value}) async {}

  @override
  Future<void> createAll({required Map<String, String> values}) async {
    // TODO: implement createAll
    throw UnimplementedError();
  }

  @override
  Future<String?> read({required String key}) async {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String?>> readAll({List<String> keys = const []}) async {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String key}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll({List<String> keys = const []}) async {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }
}
