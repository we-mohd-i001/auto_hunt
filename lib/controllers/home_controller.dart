import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/consts.dart';
import '../data/car/car_model.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<CarModel> carList = <CarModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool isError = false.obs;

  @override
  void onInit() {
    fetchCarList();
    super.onInit();
  }

  void fetchCarList() async {
    try {
      isLoading(true);
      var querySnapshot = await _firestore
          .collection(carsCollection)
          .where('is_popular', isEqualTo: true)
          .get();
      carList.assignAll(
        querySnapshot.docs
            .map(
              (doc) => CarModel(
                  brandLogo: doc['brand_logo'],
                  carBrand: doc['car_brand'],
                  carEnginePower: doc['car_engine_power'],
                  carFuelTankCapacity: doc['car_fuel_tank_capacity'],
                  carFuelType: doc['car_fuel_type'],
                  carIcon: doc['car_icon'],
                  carImages: doc['car_images'],
                  carLiked: doc['car_liked'],
                  carLocation: doc['car_location'],
                  carMaxTorque: doc['car_max_torque'],
                  carName: doc['car_name'],
                  carOwner: doc['car_owner'],
                  carPrice: doc['car_price'],
                  carRange: doc['car_range'],
                  carRating: doc['car_rating'],
                  carWheelType: doc['car_wheel_type'],
                  carCurrentFuelCapacity: doc['car_current_fuel_capacity'],
                  carRentPricePerDay: doc['car_rent_price_per_day'],
                  carRentTax: doc['car_rent_tax'],
                  carSeatingCapacity: doc['car_seating_capacity'],
                  carTransmission: doc['car_transmission']),
            )
            .toList(),
      );
      isError(false);
    } catch (e) {
      debugPrint("Error fetching cars: $e");
      isError(true);
    } finally {
      isLoading(false);
    }
  }
}
