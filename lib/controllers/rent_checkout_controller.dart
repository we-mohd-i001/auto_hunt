import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/car/car_model.dart';

class RentCheckoutController extends GetxController {
  CarModel carModel;
  RentCheckoutController({required this.carModel});

  TextEditingController pickupLocationController = TextEditingController();

  Rx<DateTime> startDate = DateTime.now().obs;
  RxString userDateAndTime = ''.obs;
  RxDouble rentDays = 1.0.obs;
  RxString pickupLocation = ''.obs;
  RxString cardDetails = ''.obs;
  RxString cardNumber = ''.obs;
  RxString cardHolder = ''.obs;
  RxString expiryDate = ''.obs;
  RxString cvv = ''.obs;
  RxBool isPageLoading = false.obs;
  RxBool isCarBookingInProgress = false.obs;

  RxString totalPrice = '0'.obs;

  RxInt rentCarButtonEnableCount = 0.obs;
  RxBool isRentCarButtonDisabled = false.obs;

  final GlobalKey<FormState> rentCheckoutFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> cardDetailFormKey = GlobalKey<FormState>();

  void enableRentCarButton() {
    print(rentCarButtonEnableCount.value);
    if (rentCarButtonEnableCount.value == pickupLocation.value.length + 2) {
      isRentCarButtonDisabled(false);
    }
  }

  Future<void> loadCarBookedDialog() async {
    isCarBookingInProgress(true);
    await Future.delayed(
        const Duration(seconds: 2), () => isCarBookingInProgress(false));
  }

  String getTotalRentPrice(int rentPrice, int carRentTax) {
    double total = (rentPrice * rentDays.value) + carRentTax;
    totalPrice('$total');
    return '$total';
  }

  void addPickupLocation(String userPickupLocation) {
    enableRentCarButton();
    pickupLocation(userPickupLocation);
  }

  void updateStartDate(DateTime userStartDate) {
    rentCarButtonEnableCount++;
    enableRentCarButton();
    startDate(userStartDate);
  }

  void addCardNumber(String userCardNumber) {
    cardNumber(userCardNumber);
  }

  void addCardHolderName(String userCardHolder) {
    cardHolder(userCardHolder);
  }

  void addExpiryDate(String userExpiryDate) {
    expiryDate(userExpiryDate);
  }

  void addCvv(String userCvv) {
    cvv(userCvv);
  }

  void addCardDetails() async {
    isPageLoading(true);
    await Future.delayed(const Duration(seconds: 2), () {
      isPageLoading(false);
    });
    rentCarButtonEnableCount + 1 + pickupLocation.value.length;
    enableRentCarButton();
    cardDetails('');
    String text =
        'Card - ${cardHolder.value} (XXXX${cardNumber.value.substring(12)})';
    cardDetails(text);
  }
}
