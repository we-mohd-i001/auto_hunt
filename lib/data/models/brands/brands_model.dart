import 'dart:convert';

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

  factory BrandsModel.fromRawJson(String str) => BrandsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
    brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "brands": List<dynamic>.from(brands.map((x) => x.toJson())),
  };
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

  factory Brand.fromRawJson(String str) => Brand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    name: json["name"],
    logoUrl: json["logoUrl"],
    cars: List<String>.from(json["cars"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "logoUrl": logoUrl,
    "cars": List<dynamic>.from(cars.map((x) => x)),
  };
}
