import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourtasks/constants/others/other_consts.dart';

import '../../../controllers/brands_controller.dart';
import '../common_widgets/car_bio.dart';
import '../common_widgets/category_list.dart';

class LikedCarListpage extends StatelessWidget {
  final User? theUser;
  const LikedCarListpage({
    super.key,
    required this.theUser,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BrandsController brandsController = Get.find<BrandsController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        surfaceTintColor: Colors.transparent,
        // backgroundColor: Colors.transparent,
        title: const Text('Liked Cars'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            categoryList(brandsController: brandsController, size: size),
            SizedBox(
              height: size.height * 0.8,
              width: size.width,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return carBio(
                    'carIndex.carName',
                    'carIndex.carFuelType',
                    OtherConsts.audiLogo,
                    size.width,
                    9000,
                    6,
                    () {},
                    'Name',
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
