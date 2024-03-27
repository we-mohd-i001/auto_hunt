import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentCheckoutController extends GetxController {
  TextEditingController pickupLocationController = TextEditingController();
  TextEditingController rentDaysController = TextEditingController();

  RxString pickupLocation = ''.obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  RxDouble rentDays = 1.0.obs;
  RxString cardDetails = ''.obs;
  RxString cardNumber = ''.obs;
  RxString cardHolder = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cvv = ''.obs;

  final rentCheckoutFormKey = GlobalKey<FormState>();
  final carDetailFormKey = GlobalKey<FormState>();

  void addPickupLocation(String userPickupLocation) {
    pickupLocation(userPickupLocation);
  }

  void updateStartDate(DateTime userStartDate) {
    startDate(userStartDate);
  }

  // static increaseDay() {
  //   if (rentDays.value <= 29) {
  //     rentDays.value += 1;
  //   }
  // }
  //
  // static decreaseDay() {
  //   if (rentDays.value >= 2) {
  //     rentDays.value -= 1;
  //   }
  // }

  void addCardNumber(String userCardNumber) {
    cardNumber(userCardNumber);
  }

  void addCardHolder(String userCardHolder) {
    cardHolder(userCardHolder);
  }

  void addExpiryDate(String userExpiryDate) {
    cardHolder(userExpiryDate);
  }

  void addCvv(String userCvv) {
    cardHolder(userCvv);
  }
}
