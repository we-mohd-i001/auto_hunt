import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/constants/consts.dart';
import '../models/car/car_model.dart';
import '../vaahextendflutter/services/logging_library/logging_library.dart';

class BrandDetailController extends GetxController {
  final String brand;
  BrandDetailController({required this.brand});

  RxList<CarModel> carList = <CarModel>[].obs;
  RxBool isLoading = true.obs;
  RxBool isError = false.obs;
  RxBool isCarLiked = false.obs;

  void fetchCarList(String brand, {bool condition = true}) async {
    if (condition == true) {
      isLoading(true);
      Log.info('Loading Cars List from Brand $brand');
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
      Log.info('Loading Complete. Fetched Cars List for $brand');
    } catch (e) {
      Log.exception('Error Loading Cars from $brand');
      debugPrint("Error fetching cars: $e");
      isError(true);
    } finally {
      if (carList.isEmpty) {
        Log.info('There are no cars from $brand.');
      } else {
        Log.info('There are ${carList.length} cars from $brand.');
      }
      isLoading(false);
    }
  }
}
