import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yourtasks/data/models/brands/brands_model.dart';

class BrandsController extends GetxController {
  var brands = [];

  getBrands(title) async {
    var data = await rootBundle.loadString("lib/services/brands_model.json");
    var decodedData = brandsModelFromJson(data);
    var s =
        decodedData.brands.where((element) => element.name == title).toList();
    for (var e in s[0].cars) {
      brands.add(e);
    }
  }
}
