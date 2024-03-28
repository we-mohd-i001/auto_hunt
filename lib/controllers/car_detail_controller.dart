import 'package:get/get.dart';

class CarDetailController extends GetxController {
  RxBool isImageOpened = false.obs;
  RxBool is360Loading = false.obs;
  RxBool areExtraDetailsVisible = false.obs;

  toggleAreExtraDetailsVisible(){
    areExtraDetailsVisible.value  = !areExtraDetailsVisible.value;
  }

  load360() async {
    is360Loading(true);
    await Future.delayed(const Duration(milliseconds: 1500), () {
      is360Loading(false);
    });
  }
}
