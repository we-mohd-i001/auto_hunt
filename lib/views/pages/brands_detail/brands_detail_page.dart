import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/brands_controller.dart';
import '../../../controllers/brand_detail_controller.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../models/car/car_model.dart';
import '../../../models/brands/brands_model.dart';
import '../../../vaahextendflutter/widgets/debug.dart';
import '../car_detail/car_detail_page.dart';
import '../common_widgets/car_detail_widget.dart';
import '../common_widgets/category_list.dart';
import '../common_widgets/custom_appbar.dart';
import '../common_widgets/error_widget_with_scaffold.dart';
import '../common_widgets/loading_widget_with_scaffold.dart';
import 'widgets/cars_error_widget.dart';

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
    final navigatorKey = GlobalKey<NavigatorState>();
    Size size = MediaQuery.of(context).size;
    BrandDetailController brandDetailController =
        Get.find<BrandDetailController>();
    BrandsController brandsController = Get.find<BrandsController>();
    brandDetailController.fetchCarList(brand.name);
    List<CarModel> carList = brandDetailController.carList;
    return DebugWidget(
      navigatorKey: navigatorKey,
      child: Obx(() {
        if (brandDetailController.isLoading.value) {
          return const LoadingWidgetWithScaffold();
        } else if (brandDetailController.isError.value) {
          return const ErrorWidgetWithScaffold(
            errorText: 'Something went Wrong!',
          );
        } else if (brandDetailController.carList.isEmpty) {
          return const CarsErrorWidget();
        }
        return Scaffold(
          //main widget to show loaded cars
          backgroundColor: AppTheme.colors['secondary']![100],
          appBar: customAppBar(
            onPressed: () {
              brandsController.selectedCategoryIndex(-1);
              Get.back();
            },
            title: 'Cars From ${brand.name}',
          ),
          body: SafeArea(
            child: Column(
              children: [
                CarCategoryListWidget(
                    brandsController: brandsController, size: size),
                SizedBox(
                  height: size.height * 0.8,
                  width: size.width,
                  child: ListView.builder(
                    itemCount: brandDetailController.carList.length,
                    itemBuilder: (BuildContext context, int index) {
                      CarModel carModel = carList[index];
                      return CarDetailWidget(
                        name: carModel.carName,
                        fuelAndType: carModel.carFuelType,
                        image: carModel.carImages[0],
                        width: size.width,
                        carRent: carModel.carRentPricePerDay,
                        seatCapacity: carModel.carSeatingCapacity,
                        onPressed: () {
                          Navigator.push(
                              context, CarDetailPage.route(user, carModel));
                        },
                        tag: '${carModel.carName}',
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
