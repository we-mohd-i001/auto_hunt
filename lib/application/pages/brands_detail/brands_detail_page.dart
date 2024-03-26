import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/brands/brands_model.dart';
import '../../../services/firestore_services.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../car_detail/car_detail_page.dart';
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
    BrandsController brandsController = Get.find<BrandsController>();
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
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No cars Found'),
            );
          } else {
            List<QueryDocumentSnapshot<Object?>> snapShotData =
                snapshot.data!.docs;
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
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.82,
                    width: size.width,
                    child: ListView.builder(
                      itemCount: snapShotData.length,
                      itemBuilder: (BuildContext context, int index) {
                        QueryDocumentSnapshot<Object?> carIndex =
                            snapShotData[index];
                        Map<String, dynamic>? data =
                            carIndex.data() as Map<String, dynamic>?;
                        if (data != null &&
                            (data.containsKey('car_name') == false ||
                                data.containsKey('car_fuel_type') == false ||
                                data.containsKey('car_images') == false ||
                                data.containsKey('car_rent_price_per_day') ==
                                    false ||
                                data.containsKey('car_seating_capacity') ==
                                    false)) {
                          return emptyWidget();
                        } else {
                          return carBio(
                              data != null && data.containsKey('car_name')
                                  ? data['car_name']
                                  : 'Unknown',
                              carIndex['car_fuel_type'],
                              carIndex['car_images'][0],
                              double.infinity,
                              carIndex['car_rent_price_per_day'],
                              carIndex['car_seating_capacity'],
                              (){
                                Get.to(CarDetailPage(data: data,),);
                              },
                            carIndex['car_name']
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

Widget emptyWidget() {
  return const SizedBox();
}
