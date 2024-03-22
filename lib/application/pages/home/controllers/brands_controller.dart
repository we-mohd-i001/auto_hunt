import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../data/models/brands/brands_model.dart';

class BrandsController extends GetxController {
  var subCat = [].obs;
  var brandsList = [].obs;
  final BuildContext context;
  RxInt selectedCategoryIndex = RxInt(-1);

  BrandsController({required this.context});

  @override
  void onInit() {
    super.onInit();
    getBrandsList();
  }

  toggleSelectedCategory(int index) {
    if(selectedCategoryIndex.value == index){
      selectedCategoryIndex.value = -1;
    } else {
      selectedCategoryIndex.value = index;
    }
  }

  getBrandsList() async {
    var rawData = await rootBundle.loadString("lib/services/brands_model.json");
    var decodedData = brandsModelFromJson(rawData);
    brandsList.value = decodedData.brands.toList();
  }

  getCarsList(title) async {
    subCat.value = [];
    var data = await rootBundle.loadString("lib/services/brands_model.json");
    var decodedData = brandsModelFromJson(data);
    var s =
        decodedData.brands.where((element) => element.name == title).toList();
    for (var e in s[0].categories) {
      subCat.add(e);
    }
  }
}
