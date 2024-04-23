import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../views/pages/login/login_page.dart';
import '../../views/pages/main_navigator/main_navigator.dart';

class SplashController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 3), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null) {
          Get.offNamed(LoginPage.routePath);
        } else {
          Get.offNamed(MyHomePage.routePath);
        }
      });
    });
    super.onInit();
  }
}
