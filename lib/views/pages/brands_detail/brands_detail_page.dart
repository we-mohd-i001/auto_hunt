import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/constants.dart';
import '../../../controllers/brands_controller.dart';
import '../../../controllers/brand_detail_controller.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../models/car/car_model.dart';
import '../../../models/brands/brands_model.dart';
import '../../../vaahextendflutter/widgets/debug.dart';
import '../car_detail/car_detail_page.dart';
import '../common_widgets/car_bio.dart';
import '../common_widgets/category_list.dart';
import '../../../helpers/commons.dart';

class BrandsDetailPage extends StatelessWidget {
  final Brand brand;
  final User? user;
  const BrandsDetailPage({
    super.key,
    required this.brand,
    required this.user,
  });

  static Route<void> route(Brand brand, User? user) {
    initializeController(brand);
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/brand'),
      builder: (_) => BrandsDetailPage(brand: brand, user: user),
    );
  }

  static initializeController(Brand brand) {
    return Get.isRegistered<BrandDetailController>()
        ? Get.find<BrandDetailController>()
        : Get.put(
            BrandDetailController(brand: brand.name),
          );
  }

  @override
  Widget build(BuildContext context) {
    final _navigatorKey = GlobalKey<NavigatorState>();
    Size size = MediaQuery.of(context).size;
    BrandDetailController brandDetailController =
        Get.find<BrandDetailController>();
    BrandsController brandsController = Get.find<BrandsController>();
    brandDetailController.fetchCarList(brand.name);
    List<CarModel> carList = brandDetailController.carList;
    return DebugWidget(
      navigatorKey: _navigatorKey,
      child: Obx(() {
        if (brandDetailController.isLoading.value) {
          return Scaffold(
              backgroundColor: AppTheme.colors['secondary']![100],
              body: const Center(
                child: CircularProgressIndicator(),
              ));
        } else if (brandDetailController.isError.value) {
          return Scaffold(
              backgroundColor: AppTheme.colors['secondary']![100],
              body: Center(
                child: Text('Something went Wrong!', style: normal),
              ));
        } else if (brandDetailController.carList.isEmpty) {
          return Scaffold(
            backgroundColor: AppTheme.colors['secondary']![100],
            appBar: AppBar(
              backgroundColor: AppTheme.colors['secondary']![100],
              surfaceTintColor: AppTheme.colors['secondary']![100],
              leading: IconButton(
                  tooltip: Strings.back,
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
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
          backgroundColor: AppTheme.colors['secondary']![100],
          appBar: AppBar(
            backgroundColor: AppTheme.colors['secondary']![100],
            surfaceTintColor: AppTheme.colors['secondary']![100],
            leading: IconButton(
              tooltip: Strings.back,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                brandsController.selectedCategoryIndex(-1);
                //Get.find<HomeController>().fetchMostPopularCarList();
                Get.back();
              },
            ),
            // backgroundColor: Colors.transparent,
            title: Text(
              'Cars From ${brand.name}',
              style: heading,
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                categoryListWidget(
                    brandsController: brandsController, size: size),
                SizedBox(
                  height: size.height * 0.8,
                  width: size.width,
                  child: ListView.builder(
                    itemCount: brandDetailController.carList.length,
                    itemBuilder: (BuildContext context, int index) {
                      CarModel carModel = carList[index];
                      return carDetailWidget(
                        carModel.carName,
                        carModel.carFuelType,
                        carModel.carImages[0],
                        size.width,
                        carModel.carRentPricePerDay,
                        carModel.carSeatingCapacity,
                        () {
                          Navigator.push(
                              context, CarDetailPage.route(user, carModel));
                        },
                        '${carModel.carName}',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
