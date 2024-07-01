import 'dart:convert';

import 'package:get/get.dart';
import 'package:yourtasks/vaahextendflutter/services/storage/network/storage.dart';

class TestAppController extends GetxController {
  RxList<CustomUser?> users = <CustomUser?>[].obs;
  RxList<CustomUser?> manyUsers = <CustomUser?>[].obs;

  @override
  void onInit() {
    super.onInit();
    hydrateList();
  }

  Future<void> hydrateList() async {
    List list = (await NetworkStorage.readAll(collectionName: 'users-collection')).values.toList();
    users.value = list.map((e) => CustomUser.fromJson(e)).toList();
  }

  void readUsers(List<String> keys) async {
    List list = (await NetworkStorage.readMany(collectionName: 'users-collection', keys: keys))
        .values
        .toList();
    manyUsers.value = list.map((e) {
      if (e != null) return CustomUser.fromJson(e);
    }).toList();
  }

  void readUser(String key) async {
    Map<String, dynamic>? user =
        (await NetworkStorage.read(collectionName: 'users-collection', key: key));
    if (user != null) {
      manyUsers.clear();
    }
  }

  void deleteUser(String key) async {
    await NetworkStorage.delete(collectionName: 'users-collection', key: key);
  }

  void deleteUsers(List<String> keys) async {
    await NetworkStorage.deleteMany(collectionName: 'users-collection', keys: keys);
  }

  void clear() {
    manyUsers.clear();
  }
}

class CustomUser {
  String name;
  String age;
  String email;
  CustomUser({
    required this.name,
    required this.age,
    required this.email,
  });

  CustomUser copyWith({
    String? name,
    String? age,
    String? email,
  }) {
    return CustomUser(
      name: name ?? this.name,
      age: age ?? this.age,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'age': age,
      'email': email,
    };
  }

  factory CustomUser.fromMap(Map<String, dynamic> map) {
    return CustomUser(
      name: map['name'] as String,
      age: map['age'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomUser.fromJson(String source) =>
      CustomUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
