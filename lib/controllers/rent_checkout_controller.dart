import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/car/car_model.dart';

class RentCheckoutController extends GetxController {
  CarModel carData;
  RentCheckoutController({required this.carData});

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

  void enableRentCarButton() {
    print(rentCarButtonEnableCount.value);
    if (rentCarButtonEnableCount.value == pickupLocation.value.length + 2) {
      isRentCarButtonDisabled(false);
    }
  }

  Future<void> loadCarBookedDialog() async {
    isCarBookingInProgress(true);
    await Future.delayed(const Duration(seconds: 2), () => isCarBookingInProgress(false));
  }

  final GlobalKey<FormState> rentCheckoutFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> cardDetailFormKey = GlobalKey<FormState>();

  String calculateTotal(int rentPrice, int carRentTax) {
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

  void addCardHolder(String userCardHolder) {
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
    print('Address - $pickupLocation');
    print('Date - $userDateAndTime');
    print('Days - $rentDays');
    print('Total Price - $totalPrice');
    rentCarButtonEnableCount + 1 + pickupLocation.value.length;

    enableRentCarButton();
    cardDetails('');
    String text =
        'Card - ${cardHolder.value} (XXXX${cardNumber.value.substring(12)})';
    cardDetails(text);
  }
}
