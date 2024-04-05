import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../constants/consts.dart';
import '../data/car/car_model.dart';

class LikedCarsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxList<CarModel> chatList = <CarModel>[].obs;

  Stream<QuerySnapshot<CarModel>> getLikedCarsList(String currentId) {
    isLoading(true);
    Stream<QuerySnapshot<CarModel>> data = firestore
        .collection(carsCollection)
        .withConverter(
            fromFirestore: CarModel.fromFirestore,
            toFirestore: (CarModel carModel, _) => carModel.toFireStore())
        .where('car_liked', arrayContains: currentId)
        .snapshots();
    isLoading(false);
    return data;
  }
}
