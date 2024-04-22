import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/brand_detail_controller.dart';
import '../../../../models/car/car_model.dart';
import '../../car_detail/car_detail_page.dart';
import '../../common_widgets/car_detail_widget.dart';

class MostPopularCars extends StatelessWidget {
  final List<CarModel> carList;
  final Size size;
  final User? user;
  const MostPopularCars(
      {super.key,
      required this.carList,
      required this.size,
      required this.user});

  @override
  Widget build(BuildContext context) {
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
            CarModel carModel = carList[index];
            return CarDetailWidget(
              name: carModel.carName,
              fuelAndType: carModel.carFuelType,
              image: carModel.carImages[0],
              width: 200.0,
              carRent: carModel.carRentPricePerDay,
              seatCapacity: carModel.carSeatingCapacity,
              onPressed: () =>
                  Navigator.push(context, CarDetailPage.route(user, carModel)),
              tag: '${carModel.carName}',
            );
          },
        ),
      ),
    );
  }
}
