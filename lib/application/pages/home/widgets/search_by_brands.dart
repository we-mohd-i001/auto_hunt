import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourtasks/constants/others/other_consts.dart';
import '../../../../constants/strings/strings.dart';
import '../../../../vaahextendflutter/app_theme.dart';
import '../controllers/brands_controller.dart';
import 'brands.dart';

Widget searchByBrands() {
  var brandsController = Get.find<BrandsController>();
  Size size = MediaQuery.of(brandsController.context).size;
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              Strings.searchByBrand,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              Strings.learnMore,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppTheme.colors['secondary']),
            )
          ],
        ),
      ),

  SizedBox(
    height: 90,
    width: size.width,
    child:
    Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: brandsController.brandsList.length,
        itemBuilder: (BuildContext context, int index){
          debugPrint('${brandsController.brandsList[index].logoUrl}');
          return
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 90,
                  width: 60,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 30,
                            child: Image.network(OtherConsts.brandsImages[index] , fit: BoxFit.contain,)),
                      ),
                      Text('${brandsController.brandsList.value[index].name}', style: const TextStyle(color: Colors.black),),
                    ],
                  )),
            );
        }),)

  ),

  //     SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //
  // //         child: ListView.builder(
  // //           scrollDirection: Axis.horizontal,
  // //           itemCount: brandsList.length,
  // //           itemBuilder: (BuildContext context, int index) {
  // //             brandsController.getBrands(index);
  // //             var brandsList = brandsController.brands;
  // //             debugPrint(brandsList.length.toString());
  // //             return Obx(
  // // () => brands(OtherConsts.bmwLogo));
  //           //},
  //           child: Row(
  //             children: [
  //               brands(OtherConsts.bmwLogo),
  //               brands(OtherConsts.teslaLogo),
  //               brands(OtherConsts.mercedesLogo),
  //               brands(OtherConsts.toyotaLogo),
  //               brands(OtherConsts.nissanLogo),
  //               brands(OtherConsts.profileImageUrl),
  //               brands(OtherConsts.profileImageUrl),
  //               brands(OtherConsts.profileImageUrl),
  //             ],
  //           ),
  //     ),
    ],
  );
}
