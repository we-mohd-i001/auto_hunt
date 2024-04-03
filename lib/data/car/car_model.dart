import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  String? brandLogo;
  String? carBrand;
  String? carEnginePower;
  String? carFuelTankCapacity;
  String? carFuelType;
  String? carIcon;
  List<dynamic> carImages;
  List<dynamic> carLiked;
  String? carLocation;
  String? carMaxTorque;
  String? carName;
  String? carOwner;
  String? carPrice;
  String? carRange;
  String? carRating;
  String? carWheelType;
  String? carCurrentFuelCapacity;
  String? carSeatingCapacity;
  String? carTransmission;
  String? carOwnerId;
  String id;
  int carRentPricePerDay;
  int carRentTax;

  CarModel({
    required this.brandLogo,
    required this.carBrand,
    required this.carEnginePower,
    required this.carFuelTankCapacity,
    required this.carFuelType,
    required this.carIcon,
    required this.carImages,
    required this.carLiked,
    required this.carLocation,
    required this.carMaxTorque,
    required this.carName,
    required this.carOwner,
    required this.carPrice,
    required this.carRange,
    required this.carRating,
    required this.carWheelType,
    required this.carCurrentFuelCapacity,
    required this.carSeatingCapacity,
    required this.carTransmission,
    required this.carRentPricePerDay,
    required this.carRentTax,
    required this.carOwnerId,
    required this.id,
  });

  factory CarModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CarModel(
      brandLogo: data?['brand_logo'],
      carBrand: data?['car_brand'],
      carEnginePower: data?['car_engine_power'],
      carFuelTankCapacity: data?['car_fuel_tank_capacity'],
      carFuelType: data?['car_fuel_type'],
      carIcon: data?['car_icon'],
      carImages: data?['car_images'],
      carLiked: data?['car_liked'],
      carLocation: data?['car_location'],
      carMaxTorque: data?['car_max_torque'],
      carName: data?['car_name'],
      carOwner: data?['car_owner'],
      carPrice: data?['car_price'],
      carRange: data?['car_range'],
      carRating: data?['car_rating'],
      carWheelType: data?['car_wheel_type'],
      carCurrentFuelCapacity: data?['car_current_fuel_capacity'],
      carRentPricePerDay: data?['car_rent_price_per_day'],
      carRentTax: data?['car_rent_tax'],
      carSeatingCapacity: data?['car_seating_capacity'],
      carTransmission: data?['car_transmission'],
      carOwnerId: data?['car_owner_id'],
      id: data?['id'],
    );
  }

  Map<String, dynamic> toFireStore() {
    return {
      if (brandLogo != null) "brand_logo": brandLogo,
      if (carBrand != null) "car_brand": carBrand,
      if (carEnginePower != null) "car_engine_power": carEnginePower,
      if (carFuelTankCapacity != null)
        "car_fuel_tank_capacity": carFuelTankCapacity,
      if (carFuelType != null) "car_fuel_type": carFuelType,
      if (carIcon != null) "car_icon": carIcon,
      "car_images": carImages,
      "car_liked": carLiked,
      if (carLocation != null) "car_location": carLocation,
      if (carMaxTorque != null) "car_max_torque": carMaxTorque,
      if (carName != null) "car_name": carName,
      if (carOwner != null) "car_owner": carOwner,
      if (carPrice != null) "car_price": carPrice,
      if (carRange != null) "car_range": carRange,
      if (carRating != null) "car_rating": carRating,
      if (carWheelType != null) "car_wheel_type": carWheelType,
      if (carCurrentFuelCapacity != null)
        "car_current_fuel_capacity": carCurrentFuelCapacity,
      "car_rent_price_per_day": carRentPricePerDay,
      "car_rent_tax": carRentTax,
      if (carSeatingCapacity != null)
        "car_seating_capacity": carSeatingCapacity,
      if (carTransmission != null) "car_transmission": carTransmission,
      if (carOwnerId != null) "car_owner_id": carOwnerId,
      "id": id,
    };
  }
}
