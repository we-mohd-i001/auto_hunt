import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:yourtasks/application/pages/login/login_page.dart';
import 'package:yourtasks/application/pages/main_navigator/main_navigator.dart';
import 'package:yourtasks/constants/consts.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(Duration(seconds: 3), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null) {
          Get.offNamed(LoginPage.routePath);
        } else {
          Get.offNamed(MyHomePage.routePath);
        }
      });
    });
    // TODO: implement onInit
    super.onInit();
  }
}
