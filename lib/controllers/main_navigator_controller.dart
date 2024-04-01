import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/consts.dart';

class MainNavigatorController extends GetxController {
  RxInt currentNavIndex = 0.obs;
  String userName = '';

  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  void getUserName() async {
    String name = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser!.uid)
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
