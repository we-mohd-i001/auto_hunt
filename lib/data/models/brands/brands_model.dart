// To parse this JSON data, do
//
//     final brandsModel = brandsModelFromJson(jsonString);

import 'dart:convert';

BrandsModel brandsModelFromJson(String str) =>
    BrandsModel.fromJson(json.decode(str));

class BrandsModel {
  List<Brand> brands;

  BrandsModel({
    required this.brands,
  });

  BrandsModel copyWith({
    List<Brand>? brands,
  }) =>
      BrandsModel(
        brands: brands ?? this.brands,
      );

  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
        brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
      );
}

class Brand {
  String name;
  String logoUrl;
  List<String> cars;

  Brand({
    required this.name,
    required this.logoUrl,
    required this.cars,
  });

  Brand copyWith({
    String? name,
    String? logoUrl,
    List<String>? cars,
  }) =>
      Brand(
        name: name ?? this.name,
        logoUrl: logoUrl ?? this.logoUrl,
        cars: cars ?? this.cars,
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        name: json["name"],
        logoUrl: json["logoUrl"],
        cars: List<String>.from(json["cars"].map((x) => x)),
      );
}
