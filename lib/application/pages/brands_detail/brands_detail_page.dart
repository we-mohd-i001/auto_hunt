import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../controllers/brands_controller.dart';
import '../../../controllers/brand_detail_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../data/car/car_model.dart';
import '../../../data/models/brands/brands_model.dart';
import '../car_detail/car_detail_page.dart';
import '../common_widgets/car_bio.dart';
import 'view_states/error_state_view.dart';
import 'view_states/loading_state_view.dart';
import '../common_widgets/category_list.dart';

class BrandsDetailPage extends StatelessWidget {
  final Brand data;
  final User? theUser;
  const BrandsDetailPage({
    super.key,
    required this.data,
    required this.theUser,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BrandDetailController brandDetailController =
        Get.put(BrandDetailController(brand: data.name));
    BrandsController brandsController = Get.find<BrandsController>();
    brandDetailController.fetchCarList(data.name);
    List<CarModel> carList = brandDetailController.carList;
    return Obx(() {
      if (brandDetailController.isLoading.value) {
        return const Scaffold(body: LoadingStateView());
      } else if (brandDetailController.isError.value) {
        return const ErrorStateView();
      } else if (brandDetailController.carList.isEmpty) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                tooltip: Strings.back,
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                )),
          ),
          body: Center(
            child: ButtonOutlined(
              buttonType: ButtonType.danger,
              text: 'No cars Found Go Back',
              borderRadius: 8,
              onPressed: () => Get.back(),
            ),
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: Strings.back,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              brandsController.selectedCategoryIndex(-1);
              Get.find<HomeController>().fetchMostPopularCarList();
              Get.back();
            },
          ),
          surfaceTintColor: Colors.transparent,
          // backgroundColor: Colors.transparent,
          title: Text('Cars From ${data.name}'),
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
    });
  }
}
