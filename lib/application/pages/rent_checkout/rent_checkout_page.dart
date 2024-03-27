import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../common_widgets/my_custom_button.dart';
import 'controller/rent_checkout_controller.dart';
import 'widgets/car_bio_mini.dart';
import 'widgets/rent_detail_form.dart';

class RentCheckoutPage extends StatelessWidget {
  const RentCheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    RentCheckoutController rentCheckoutController =
        Get.put(RentCheckoutController());
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
                    carBioMini(),
                    verticalMargin8,
                    Obx(() => rentDetailForm(rentCheckoutController))
                  ],
                ),
              ),
            ),
            myCustomButton(
                onPressed: () {}, tag: 'hero-1', text: Strings.rentCar),
          ],
        ),
      ),
    );
  }
}
