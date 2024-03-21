import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:yourtasks/data/models/brands/brands_model.dart';

class BrandsController extends GetxController {
  var carsList = [].obs;
  var brandsList = [].obs;
  final BuildContext context;

  BrandsController({required this.context} );

  @override
  void onInit(){
    super.onInit();
    getBrandsList();
  }

  getBrandsList()async{
    var rawData = await rootBundle.loadString("lib/services/brands_model.json");
    var decodedData = brandsModelFromJson(rawData);
    brandsList.value = decodedData.brands.toList();
    print(brandsList.value[0].name);
  }

  getCarsList(title) async {
    var data = await rootBundle.loadString("lib/services/brands_model.json");
    var decodedData = brandsModelFromJson(data);
    var s =
        decodedData.brands.where((element) => element.name == title).toList();
    for (var e in s[0].cars) {
      carsList.add(e);
    }
  }
}
