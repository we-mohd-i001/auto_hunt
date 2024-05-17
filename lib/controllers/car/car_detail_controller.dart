import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../helpers/constants/consts.dart';
import '../../vaahextendflutter/helpers/alerts.dart';
import '../../vaahextendflutter/services/logging_library/logging_library.dart';

class CarDetailController extends GetxController {
  CarDetailController({
    required this.carLikedList,
    required this.user,
  });

  final List<dynamic> carLikedList;
  final User? user;

  RxBool isImageOpened = false.obs;
  RxBool areExtraDetailsVisible = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isCarLiked = false.obs;

  @override
  void onInit() {
    checkIfLiked();
    super.onInit();
  }

  void checkIfLiked() async {
    Log.info('Checking if car is Liked...');
    if (carLikedList.contains(user!.uid)) {
      Log.info('Car is Liked.');
      isCarLiked(true);
    } else {
      Log.info('Car is Not Liked.');
      isCarLiked(false);
    }
  }

  void toggleAreExtraDetailsVisible() {
    areExtraDetailsVisible.value = !areExtraDetailsVisible.value;
  }

  void addToLikedCars(
      {required String carId, required String currentId}) async {
    try {
      await _firestore.collection(carsCollection).doc(carId).set({
        'car_liked': FieldValue.arrayUnion([currentId])
      }, SetOptions(merge: true));
      Log.info('$carId Added to Liked Cars List.');
    } on Exception catch (e) {
      Alerts.showErrorToast!(content: 'Something went wrong!');
      Log.exception(
          'Exception $e occured while adding $carId to Liked cars list.');
    }
  }

  void removeFromLikedCars(
      {required String carId, required String currentId}) async {
    try {
      await _firestore.collection(carsCollection).doc(carId).set({
        'car_liked': FieldValue.arrayRemove([currentId])
      }, SetOptions(merge: true));
      Log.info('$carId removed from Liked Cars List.');
    } on Exception catch (e) {
      Alerts.showErrorToast!(content: 'Something went wrong!');
      Log.exception(
          'Exception $e occured while adding $carId to Liked cars list.');
    }
  }
}
