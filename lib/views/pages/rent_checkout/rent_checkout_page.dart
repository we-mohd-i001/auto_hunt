import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/constants.dart';
import '../../../models/car/car_model.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../helpers/commons.dart';
import '../common_widgets/custom_appbar.dart';
import '../common_widgets/my_custom_button.dart';
import '../../../controllers/rent/rent_checkout_controller.dart';
import '../main_navigator/main_navigator.dart';
import 'widgets/car_bio_mini.dart';
import 'widgets/rent_detail_form.dart';

class RentCheckoutPage extends StatelessWidget {
  final CarModel carModel;
  const RentCheckoutPage({super.key, required this.carModel});
  static Route<void> route(CarModel carModel) {
    initializeController(carModel);
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/rent_checkout'),
      builder: (_) => RentCheckoutPage(
        carModel: carModel,
      ),
    );
  }

  static initializeController(CarModel carModel) {
    return Get.isRegistered<RentCheckoutController>()
        ? Get.find<RentCheckoutController>()
        : Get.put(RentCheckoutController(carModel: carModel));
  }

  @override
  Widget build(BuildContext context) {
    RentCheckoutController rentCheckoutController =
        Get.find<RentCheckoutController>();
    return Scaffold(
      backgroundColor: AppTheme.colors['secondary']![100],
      appBar: customAppBar(
        title: Strings.rentDetail,
        onPressed: () {
          rentCheckoutController.rentCarButtonEnableCount(0);
          Get.delete<RentCheckoutController>();
          Get.back();
        },
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
                      CarBioMini(
                          carIcon: '${carModel.carIcon}',
                          carName: '${carModel.carName}',
                          currentFuelCapacity:
                              '${carModel.carCurrentFuelCapacity}',
                          carFuelType: '${carModel.carFuelType}'),
                      verticalMargin8,
                      const RentDetailForm(),
                    ],
                  ),
                ),
              ),
              MyCustomButton(
                  type: ButtonType.primary,
                  onPressed: () async {
                    if (rentCheckoutController.rentCheckoutFormKey.currentState!
                        .validate()) {
                      await rentCheckoutController.loadCarBookedDialog();
                      Get.defaultDialog(
                          barrierDismissible: false,
                          title: Strings.carBookedSuccessfully,
                          titleStyle: subheading,
                          middleText:
                              '${Strings.yourCarIsBookedFor} ${rentCheckoutController.rentDays} ${Strings.days}, you can expect your car on ${rentCheckoutController.userDateAndTime}. ${Strings.totalRentPrice} is ${rentCheckoutController.totalPrice}',
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
                  color: AppTheme.colors['black']!.withOpacity(0.2),
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
