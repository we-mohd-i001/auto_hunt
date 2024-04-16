import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/constants/consts.dart';
import '../models/car/car_model.dart';

class SearchCarsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxList<CarModel> carList = <CarModel>[].obs;
  TextEditingController searchTextController = TextEditingController();

  void getCarList({required String keyword}) async {
    try {
      isLoading(true);
      Future<QuerySnapshot<CarModel>> data = firestore
          .collection(carsCollection)
          .withConverter(
              fromFirestore: CarModel.fromFirestore,
              toFirestore: (CarModel carModel, _) => carModel.toFireStore())
          .where('car_keywords', arrayContains: keyword)
          .get();
      data.then((value) {
        carList.value = value.docs.map((e) => e.data.call()).toList();
        debugPrint('carList $carList');
      });
    } catch (e) {
      isError(true);
    } finally {
      isLoading(false);
    }
  }
}
