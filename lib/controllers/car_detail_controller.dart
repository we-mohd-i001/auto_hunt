import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../constants/consts.dart';

class CarDetailController extends GetxController {
  final List<dynamic> carLikedList;
  final User? user;

  RxBool isImageOpened = false.obs;
  RxBool is360Loading = false.obs;
  RxBool areExtraDetailsVisible = false.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isCarLiked = false.obs;

  @override
  void onInit() {
    checkIfLiked();
    super.onInit();
  }

  CarDetailController({required this.carLikedList, required this.user});

  toggleAreExtraDetailsVisible() {
    areExtraDetailsVisible.value = !areExtraDetailsVisible.value;
  }

  load360() async {
    is360Loading(true);
    await Future.delayed(const Duration(milliseconds: 1500), () {
      is360Loading(false);
    });
  }

  void addToLikedCarsList(
      {required String carId, required String currentId}) async {
    await _firestore.collection(carsCollection).doc(carId).set({
      'car_liked': FieldValue.arrayUnion([currentId])
    }, SetOptions(merge: true));
  }

  void removeFromLikedCarsList(
      {required String carId, required String currentId}) async {
    await _firestore.collection(carsCollection).doc(carId).set({
      'car_liked': FieldValue.arrayRemove([currentId])
    }, SetOptions(merge: true));
  }

  void checkIfLiked() async {
    if (carLikedList.contains(user!.uid)) {
      isCarLiked(true);
    } else {
      isCarLiked(false);
    }
  }
}
