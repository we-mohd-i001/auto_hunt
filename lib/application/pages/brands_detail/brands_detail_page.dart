import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourtasks/vaahextendflutter/widgets/atoms/buttons.dart';

import '../../../data/car/car_model.dart';
import '../../../data/models/brands/brands_model.dart';
import '../../../controllers/brand_detail_controller.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import 'view_states/error_state_view.dart';
import 'view_states/loaded_state_view.dart';
import 'view_states/loading_state_view.dart';

class BrandsDetailPage extends StatelessWidget {
  final Brand data;
  const BrandsDetailPage({
    super.key,
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    BrandDetailController brandDetailController =
        Get.put(BrandDetailController(brand: data.name));
    List<CarModel> carList = brandDetailController.carList.value;
    Size size = MediaQuery.of(context).size;
    return Scaffold(body: SafeArea(
      child: Obx(() {
        if (brandDetailController.isLoading.value) {
          return const LoadingStateView();
        } else if (brandDetailController.isError.value) {
          return const ErrorStateView();
        } else if (brandDetailController.carList.isEmpty) {
          return Center(
            child: ButtonOutlined(
              buttonType: ButtonType.danger,
              text: 'No cars Found Go Back',
              borderRadius: 8,
              onPressed: () => Get.back(),
            ),
          );
        }
        return LoadedStateView(
          carList: carList,
          carBrand: data.name,
        );
      }),
    ));
  }
}
