import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../data/models/brands/brands_model.dart';

class BrandsController extends GetxController {
  RxList<dynamic> subCat = [].obs;
  RxList<dynamic> brandsList = [].obs;
  final BuildContext context;
  RxInt selectedCategoryIndex = RxInt(-1);

  BrandsController({required this.context});

  @override
  void onInit() {
    super.onInit();
    getBrandsList();
  }

  void toggleSelectedCategory(int index) {
    if (selectedCategoryIndex.value == index) {
      selectedCategoryIndex.value = -1;
    } else {
      selectedCategoryIndex.value = index;
    }
  }

  void getBrandsList() async {
    String rawData = await rootBundle.loadString("lib/services/brands_model.json");
    BrandsModel decodedData = brandsModelFromJson(rawData);
    brandsList.value = decodedData.brands.toList();
  }

  void getCarsList(title) async {
    subCat.value = [];
    String data = await rootBundle.loadString("lib/services/brands_model.json");
    BrandsModel decodedData = brandsModelFromJson(data);
    List<Brand> brandList =
        decodedData.brands.where((element) => element.name == title).toList();
    for (Category e in brandList[0].categories) {
      subCat.add(e);
    }
  }
}
