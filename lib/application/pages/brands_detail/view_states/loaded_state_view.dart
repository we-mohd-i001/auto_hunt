import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/car/car_model.dart';
import '../../car_detail/car_detail_page.dart';
import '../../common_widgets/car_bio.dart';
import '../../../../controllers/brands_controller.dart';
import '../../../../controllers/brand_detail_controller.dart';
import '../../common_widgets/category_list.dart';

class LoadedStateView extends StatelessWidget {
  final List<CarModel> carList;
  final User? theUser;
  final String carBrand;
  const LoadedStateView({
    super.key,
    required this.carList,
    required this.carBrand,
    required this.theUser,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BrandsController brandsController = Get.find<BrandsController>();
    BrandDetailController brandDetailController =
        Get.put(BrandDetailController(brand: carBrand));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            brandsController.selectedCategoryIndex(-1);
            brandDetailController.dispose();
            Get.back();
          },
        ),
        surfaceTintColor: Colors.transparent,
        // backgroundColor: Colors.transparent,
        title: Text('Cars From $carBrand'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            categoryList(brandsController: brandsController, size: size),
            SizedBox(
              height: size.height * 0.8,
              width: size.width,
              child: ListView.builder(
                itemCount: brandDetailController.carList.length,
                itemBuilder: (BuildContext context, int index) {
                  CarModel carIndex = carList[index];
                  return carBio(
                    carIndex.carName,
                    carIndex.carFuelType,
                    carIndex.carImages[0],
                    size.width,
                    carIndex.carRentPricePerDay,
                    carIndex.carSeatingCapacity,
                    () {
                      Get.to(
                        () => CarDetailPage(
                          data: carIndex,
                          theUser: theUser,
                        ),
                      );
                    },
                    '${carIndex.carName}',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
