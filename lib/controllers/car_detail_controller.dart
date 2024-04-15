import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../helpers/constants/consts.dart';
import '../vaahextendflutter/helpers/alerts.dart';

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

  void toggleAreExtraDetailsVisible() {
    areExtraDetailsVisible.value = !areExtraDetailsVisible.value;
  }

  void addToLikedCarsList(
      {required String carId, required String currentId}) async {
    try {
      await _firestore.collection(carsCollection).doc(carId).set({
        'car_liked': FieldValue.arrayUnion([currentId])
      }, SetOptions(merge: true));
    } on Exception catch (_) {
      Alerts.showErrorToast!(content: 'Something went wrong!');
    }
  }

  void removeFromLikedCarsList(
      {required String carId, required String currentId}) async {
    try {
      await _firestore.collection(carsCollection).doc(carId).set({
        'car_liked': FieldValue.arrayRemove([currentId])
      }, SetOptions(merge: true));
    } on Exception catch (_) {
      Alerts.showErrorToast!(content: 'Something went wrong!');
    }
  }

  void checkIfLiked() async {
    if (carLikedList.contains(user!.uid)) {
      isCarLiked(true);
    } else {
      isCarLiked(false);
    }
  }
}
