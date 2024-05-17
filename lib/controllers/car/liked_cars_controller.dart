import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../helpers/constants/consts.dart';
import '../../models/car/car_model.dart';

class LikedCarsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isError = false.obs;
  RxList<CarModel> carList = <CarModel>[].obs;

  Stream<QuerySnapshot<CarModel>> getLikedCars(String currentId) {
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
