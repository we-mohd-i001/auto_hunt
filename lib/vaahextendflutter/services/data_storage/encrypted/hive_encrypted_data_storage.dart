import '../storage.dart';

class HiveEncryptedStorage implements Storage {
  String? name;
  HiveEncryptedStorage({this.name = 'default'});

  @override
  Future<void> create({required String key, required String value}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<void> createAll({required Map<String, String> values}) {
    // TODO: implement createAll
    throw UnimplementedError();
  }

  @override
  Future<void> delete({required String key}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAll({List<String> keys = const []}) {
    // TODO: implement deleteAll
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<String?> read({required String key}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Map<String, String?>> readAll({List<String> keys = const []}) {
    // TODO: implement readAll
    throw UnimplementedError();
  }
}
