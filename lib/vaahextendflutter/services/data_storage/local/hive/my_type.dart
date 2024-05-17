// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

@HiveType(typeId: 2)
class MyType extends JsonSerializable {
  @HiveField(0)
  String name;

  @HiveField(1)
  int age;
  MyType({
    required this.name,
    required this.age,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }

  factory MyType.fromJson(Map<String, dynamic> json) {
    return MyType(
      name: json['name'],
      age: json['age'],
    );
  }
}
