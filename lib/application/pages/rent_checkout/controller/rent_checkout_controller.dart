import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/car/car_model.dart';

class RentCheckoutController extends GetxController {
  CarModel carData;
  RentCheckoutController({required this.carData});

  TextEditingController pickupLocationController = TextEditingController();
  TextEditingController rentDaysController = TextEditingController();

  Rx<DateTime> startDate = DateTime.now().obs;
  RxDouble rentDays = 1.0.obs;
  RxString pickupLocation = ''.obs;
  RxString cardDetails = ''.obs;
  RxString cardNumber = ''.obs;
  RxString cardHolder = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cvv = ''.obs;

  final GlobalKey rentCheckoutFormKey = GlobalKey<FormState>();
  final GlobalKey carDetailFormKey = GlobalKey<FormState>();

  String calculateTotal(int rentPrice, int carRentTax){
    double total =( rentPrice * rentDays.value ) + carRentTax;
    return '$total';
  }

  void addPickupLocation(String userPickupLocation) {
    pickupLocation(userPickupLocation);
  }

  void updateStartDate(DateTime userStartDate) {
    startDate(userStartDate);
  }

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
