import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../helpers/constants/consts.dart';

class MainNavigatorController extends GetxController {
  RxInt currentNavIndex = 0.obs;
  String userName = '';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  void getUserName() async {
    String name = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      } else {
        throw PlatformException(code: '2');
      }
    });
    userName = name;
  }
}
