import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/others/other_consts.dart';
import '../../../../data/car/car_model.dart';
import '../../car_detail/car_detail_page.dart';
import '../../common_widgets/car_bio.dart';

Widget mostPopularCars({required List<CarModel> carList, required Size size}) {
  return SizedBox(
    height: 280,
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
