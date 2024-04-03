import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/brand_detail_controller.dart';
import '../../../../data/car/car_model.dart';
import '../../car_detail/car_detail_page.dart';
import '../../common_widgets/car_bio.dart';

Widget mostPopularCars(
    {required List<CarModel> carList,
    required Size size,
    required User? theUser}) {
  BrandDetailController brandDetailController =
      Get.put(BrandDetailController(brand: '${carList[0].carBrand}'));
  return SizedBox(
    height: 300,
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: carList.length,
        itemBuilder: (BuildContext context, int index) {
          CarModel carIndex = carList[index];
          return carBio(
            carIndex.carName,
            carIndex.carFuelType,
            carIndex.carImages[0],
            200.0,
            carIndex.carRentPricePerDay,
            carIndex.carSeatingCapacity,
            () {
              Get.to(
                CarDetailPage(
                  data: carIndex,
                  theUser: theUser,
                ),
              );
            },
            '${carIndex.carName}',
          );
        },
      ),
    ),
  );
}
