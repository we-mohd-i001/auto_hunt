import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../data/car/car_model.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../common_widgets/my_custom_button.dart';
import 'controller/rent_checkout_controller.dart';
import 'widgets/car_bio_mini.dart';
import 'widgets/rent_detail_form.dart';

class RentCheckoutPage extends StatelessWidget {
  CarModel carData;
  RentCheckoutPage({super.key, required this.carData});

  @override
  Widget build(BuildContext context) {
    RentCheckoutController rentCheckoutController =
        Get.put(RentCheckoutController(carData: carData));
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.rentDetail),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    carBioMini(
                        carIcon: '${carData.carIcon}',
                        carName: '${carData.carName}',
                        currentFuelCapacity: '${carData.carCurrentFuelCapacity}',
                        carFuelType: '${carData.carFuelType}'),
                    verticalMargin8,
                    Obx(() => rentDetailForm())
                  ],
                ),
              ),
            ),
            myCustomButton(
                onPressed: () {}, tag: 'hero-1', text: Strings.rentCar),
            Visibility(
                visible: false,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  height: double.infinity,
                  width: double.infinity,
                  child: const Center(child: CircularProgressIndicator()),))
          ],
        ),
      ),
    );
  }
}
