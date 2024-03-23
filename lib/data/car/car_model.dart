import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  String? name;
  String? brand;
  String? fuelType;
  String? seatingCapacity;
  double? rentPricePerDay;
  List<String?> images;

  CarModel(
      {required this.name,
      required this.brand,
      required this.fuelType,
      required this.images,
      required this.rentPricePerDay,
      required this.seatingCapacity});

  factory CarModel.fromFirestore(QueryDocumentSnapshot<Object?> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return CarModel(
      name: data['car_name'] ?? 'Unknown',
      fuelType: data['car_fuel_type'] ?? 'Unknown',
      images: data['car_images'] ?? [''],
      rentPricePerDay: data['car_rent_price_per_day'] ?? 0.0,
      seatingCapacity: data['car_seating_capacity'] ?? '0',
      brand: data['car_brand'] ?? '',
    );
  }
}
