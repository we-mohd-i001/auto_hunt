import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/constants/consts.dart';
import '../models/car/car_model.dart';

class HomeController extends GetxController {
  RxList<CarModel> carList = <CarModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool isError = false.obs;

  @override
  void onInit() {
    fetchMostPopularCars();
    super.onInit();
  }

  void fetchMostPopularCars() async {
    try {
      isLoading(true);
      await firestore
          .collection(carsCollection)
          .where('is_popular', isEqualTo: true)
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
