import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/constants.dart';
import '../../../controllers/liked_cars_controller.dart';
import '../../../models/car/car_model.dart';
import '../ui/components/commons.dart';
import '../car_detail/car_detail_page.dart';
import '../common_widgets/car_bio.dart';

class LikedCarListPage extends StatelessWidget {
  final User? user;
  const LikedCarListPage({
    super.key,
    required this.user,
  });

  static Route<void> route(User? user) {
    initializeController();
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/liked_cars_page'),
      builder: (_) => LikedCarListPage(
        user: user,
      ),
    );
  }

  static initializeController() {
    return Get.isRegistered<LikedCarsController>()
        ? Get.find<LikedCarsController>()
        : Get.put(
            LikedCarsController(),
          );
  }

  @override
  Widget build(BuildContext context) {
    LikedCarsController likedCarsController = Get.find<LikedCarsController>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: Strings.back,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        surfaceTintColor: Colors.transparent,
        title: const Text('Liked Cars'),
      ),
      body: SafeArea(
        child: SizedBox(
          height: size.height * 0.87,
          width: size.width,
          child: StreamBuilder(
              stream: likedCarsController.getLikedCarsList(user!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<CarModel>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Something went wrong!', style: normal),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('Liked cars will appear here!', style: normal),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    CarModel carModelAtIndex =
                        snapshot.data!.docs[index].data.call();
                    return carDetailWidget(
                      carModelAtIndex.carName,
                      carModelAtIndex.carFuelType,
                      carModelAtIndex.carImages[0],
                      size.width,
                      carModelAtIndex.carRentPricePerDay,
                      carModelAtIndex.carSeatingCapacity,
                      () {
                        Navigator.push(context,
                            CarDetailPage.route(user, carModelAtIndex));
                      },
                      '${carModelAtIndex.carName}',
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
