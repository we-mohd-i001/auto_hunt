import '../storage.dart';

class HiveLocalDataEncryptedStorage implements Storage {
  String? name;
  HiveLocalDataEncryptedStorage({this.name = 'default'});

  @override
  Future<void> create({key, value}) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  void delete({key}) {
    // TODO: implement delete
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future read({key}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future update({key, value}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
