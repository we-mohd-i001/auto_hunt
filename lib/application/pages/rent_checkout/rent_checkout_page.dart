import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../data/car/car_model.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../views/pages/ui/components/commons.dart';
import '../common_widgets/my_custom_button.dart';
import '../../../controllers/rent_checkout_controller.dart';
import '../main_navigator/main_navigator.dart';
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
        leading: IconButton(
          onPressed: () {
            rentCheckoutController.rentCarButtonEnableCount(0);
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(Strings.rentDetail),
      ),
      body: SafeArea(
        child: Obx(
          () => Stack(
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
                          currentFuelCapacity:
                              '${carData.carCurrentFuelCapacity}',
                          carFuelType: '${carData.carFuelType}'),
                      verticalMargin8,
                      rentDetailForm(),
                    ],
                  ),
                ),
              ),
              myCustomButton(
                  type: ButtonType.primary,
                  onPressed: () async {
                    if (rentCheckoutController.rentCheckoutFormKey.currentState!
                        .validate()) {
                      await rentCheckoutController.loadCarBookedDialog();
                      Get.defaultDialog(
                          barrierDismissible: false,
                          title: Strings.carBookedSuccessfully,
                          titleStyle: subheading,

                          middleText: '${Strings.yourCarIsBookedFor} ${rentCheckoutController.rentDays} ${Strings.days}, you can expect your car on ${rentCheckoutController.userDateAndTime}. ${Strings.totalRentPrice} is ${rentCheckoutController.totalPrice}',
                          middleTextStyle: normal,
                          radius: 12,
                          actions: [
                            ButtonOutlined(
                                buttonType: ButtonType.success,
                                onPressed: () {
                                  Get.offAllNamed(MyHomePage.routePath);
                                },
                                text: Strings.ok)
                          ]);
                    }
                  },
                  tag: 'hero-1',
                  text: Strings.rentCar),
              Visibility(
                visible: rentCheckoutController.isPageLoading.value ||
                    rentCheckoutController.isCarBookingInProgress.value,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                      child: CircularProgressIndicator(
                          color: AppTheme.colors['primary'])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
