import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helpers/constants/others/other_consts.dart';
import '../../brands_detail/brands_detail_page.dart';
import '../../../../controllers/brand/brands_controller.dart';
import '../../../../helpers/commons.dart';

class SearchByBrands extends StatelessWidget {
  final Size size;
  final User? user;
  const SearchByBrands({super.key, required this.size, required this.user});

  @override
  Widget build(BuildContext context) {
    BrandsController brandsController = Get.find<BrandsController>();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 80,
        width: size.width,
        child: Obx(
          () => ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brandsController.brandsList.length,
            itemBuilder: (BuildContext context, int index) {
              debugPrint('${brandsController.brandsList[index].logoUrl}');
              return SizedBox(
                width: 100,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onPressed: () {
                    brandsController
                        .getCars(brandsController.brandsList[index].name);
                    Navigator.push(
                      context,
                      BrandsDetailPage.route(
                          brandsController.brandsList[index], user),
                    );
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4, top: 8),
                        child: SizedBox(
                          height: 30,
                          child: Image.network(
                            OtherConsts.brandsImages[index],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Text('${brandsController.brandsList[index].name}',
                          style: subheadingBlack),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
