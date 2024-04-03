import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/consts.dart';
import '../data/car/car_model.dart';

class BrandDetailController extends GetxController {
  final String brand;
  BrandDetailController({required this.brand});

  RxList<CarModel> carList = <CarModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool isError = false.obs;
  RxBool isCarLiked = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void fetchCarList(String brand, {bool condition = true}) async {
    if (condition == true) {
      isLoading(true);
    } else {
      isLoading(false);
    }
    try {
      await firestore
          .collection(carsCollection)
          .where('car_brand', isEqualTo: brand)
          .withConverter(
              fromFirestore: CarModel.fromFirestore,
              toFirestore: (CarModel carModel, _) => carModel.toFireStore())
          .get()
          .then((QuerySnapshot<CarModel> querySnapshot) {
        var docSnapshot = querySnapshot.docs;
        carList.assignAll(docSnapshot.map((doc) => doc.data.call()).toList());
      });
      isError(false);
    } catch (e) {
      debugPrint("Error fetching cars: $e");
      isError(true);
    } finally {
      isLoading(false);
    }
  }
}
