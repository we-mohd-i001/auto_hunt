import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/brands/brands_model.dart';
import '../../../../vaahextendflutter/helpers/constants.dart';
import '../../../../vaahextendflutter/helpers/enums.dart';
import '../../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../../views/pages/home.dart';
import '../../../../controllers/brands_controller.dart';

Widget categoryList({
  required BrandsController brandsController,
  required Size size,
}) {
  return Container(
    color: Colors.transparent,
    width: size.width,
    height: size.height * 0.07,
    child: Obx(
          () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            brandsController.subCat.value.length,
                (index) {
              String cat = '';
              Category category = brandsController.subCat.value[index];
              if (category == Category.HATCHBACK) {
                cat = 'Hatchback';
              } else if (category == Category.LUXURY) {
                cat = 'Luxury';
              } else if (category == Category.SEDAN) {
                cat = 'Sedan';
              } else if (category == Category.SPORTS) {
                cat = 'Sports';
              } else {
                cat = 'No Categories';
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
                  text: cat,
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}
