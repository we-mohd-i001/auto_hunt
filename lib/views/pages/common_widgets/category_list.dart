import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/brands/brands_model.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../home.dart';
import '../../../controllers/brands_controller.dart';

Widget categoryListWidget({
  required BrandsController brandsController,
  required Size size,
}) {
  return Container(
    color: AppTheme.colors['white']!.withOpacity(0.0),
    width: size.width,
    height: size.height * 0.07,
    child: Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            brandsController.subCat.length,
            (index) {
              String categoryString = '';
              Category category = brandsController.subCat[index];
              if (category == Category.HATCHBACK) {
                categoryString = 'Hatchback';
              } else if (category == Category.LUXURY) {
                categoryString = 'Luxury';
              } else if (category == Category.SEDAN) {
                categoryString = 'Sedan';
              } else if (category == Category.SPORTS) {
                categoryString = 'Sports';
              } else {
                categoryString = 'No Categories';
              }
              return Padding(
                padding: allPadding8,
                child: ButtonOutlined(
                  borderRadius: 8,
                  buttonType:
                      index == brandsController.selectedCategoryIndex.value
                          ? ButtonType.primary
                          : ButtonType.secondary,
                  onPressed: () {
                    brandsController.toggleSelectedCategory(index);
                    //Todo: Remove this route this is only for testing
                    Get.to(const HomePage());
                  },
                  text: categoryString,
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}
