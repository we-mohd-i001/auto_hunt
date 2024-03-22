// To parse this JSON data, do
//
//     final brandsModel = brandsModelFromJson(jsonString);

import 'dart:convert';

BrandsModel brandsModelFromJson(String str) => BrandsModel.fromJson(json.decode(str));


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
  List<Category> categories;
  List<String> cars;

  Brand({
    required this.name,
    required this.logoUrl,
    required this.categories,
    required this.cars,
  });

  Brand copyWith({
    String? name,
    String? logoUrl,
    List<Category>? categories,
    List<String>? cars,
  }) =>
      Brand(
        name: name ?? this.name,
        logoUrl: logoUrl ?? this.logoUrl,
        categories: categories ?? this.categories,
        cars: cars ?? this.cars,
      );

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    name: json["name"],
    logoUrl: json["logoUrl"],
    categories: List<Category>.from(json["categories"].map((x) => categoryValues.map[x]!)),
    cars: List<String>.from(json["cars"].map((x) => x)),
  );

}

enum Category {
  HATCHBACK,
  LUXURY,
  SEDAN,
  SPORTS
}

final categoryValues = EnumValues({
  "Hatchback": Category.HATCHBACK,
  "Luxury": Category.LUXURY,
  "Sedan": Category.SEDAN,
  "Sports": Category.SPORTS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
