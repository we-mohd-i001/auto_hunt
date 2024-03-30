import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/others/other_consts.dart';
import '../../brands_detail/brands_detail_page.dart';
import '../../../../controllers/brands_controller.dart';

Widget searchByBrands({required Size size}) {
  BrandsController brandsController = Get.find<BrandsController>();

  return SizedBox(
    height: 80,
    width: size.width,
    child: Obx(
      () => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: brandsController.brandsList.length,
        itemBuilder: (BuildContext context, int index) {
          debugPrint('${brandsController.brandsList[index].logoUrl}');
          return SizedBox(
            width: 100,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {
                brandsController
                    .getCarsList(brandsController.brandsList.value[index].name);
                Get.to(
                  () => BrandsDetailPage(
                    data: brandsController.brandsList.value[index],
                  ),
                );
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4, top: 8),
                    child: SizedBox(
                        height: 30,
                        child: Image.network(
                          OtherConsts.brandsImages[index],
                          fit: BoxFit.contain,
                        )),
                  ),
                  Text(
                    '${brandsController.brandsList.value[index].name}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
