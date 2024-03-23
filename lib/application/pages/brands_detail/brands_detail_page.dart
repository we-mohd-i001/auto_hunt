import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourtasks/services/firestore_services.dart';
import '../../../constants/others/other_consts.dart';
import '../../../data/models/brands/brands_model.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../common_widgets/car_bio.dart';
import '../home/controllers/brands_controller.dart';

class BrandsDetailPage extends StatelessWidget {
  final Brand data;
  const BrandsDetailPage({
    super.key,
    required this.data,
  });
  @override
  Widget build(BuildContext context) {
    var brandsController = Get.find<BrandsController>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              brandsController.selectedCategoryIndex(-1);
              Get.back();
            },
          ),
          surfaceTintColor: Colors.transparent,
          // backgroundColor: Colors.transparent,
          title: Text('Cars From ${data.name}'),
        ),
        body: StreamBuilder(
          stream: FireStoreServices.getCars(data.name),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No cars Found'),
              );
            } else {
              var snapShotData = snapshot.data!.docs;
              return SafeArea(
                child: Column(
                  children: [
                    Container(
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
                            Category category =
                                brandsController.subCat.value[index];
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
                                buttonType: index ==
                                        brandsController
                                            .selectedCategoryIndex.value
                                    ? ButtonType.primary
                                    : ButtonType.secondary,
                                onPressed: () {
                                  brandsController
                                      .toggleSelectedCategory(index);
                                  print(brandsController
                                      .selectedCategoryIndex.value);
                                },
                                text: cat,
                              ),
                            );
                          })),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.82,
                      width: size.width,
                      child: ListView.builder(
                        itemCount: snapShotData.length,
                        itemBuilder: (BuildContext context, int index) {
                          var carIndex = snapShotData[index];
                          return carBio(
                              carIndex['car_name'],
                              carIndex['car_fuel_type'],
                              carIndex['car_images'][0],
                              double.infinity,
                              carIndex['car_rent_price_per_day'],
                              carIndex['car_seating_capacity']);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}
