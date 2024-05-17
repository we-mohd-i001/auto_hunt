import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/constants.dart';
import '../../../controllers/car/liked_cars_controller.dart';
import '../../../models/car/car_model.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../helpers/commons.dart';
import '../car_detail/car_detail_page.dart';
import '../common_widgets/car_detail_widget.dart';
import '../common_widgets/custom_appbar.dart';

class LikedCarListPage extends StatelessWidget {
  final User? user;
  const LikedCarListPage({
    super.key,
    required this.user,
  });

  static Route<void> route(User? user) {
    _initialize();
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/liked_cars_page'),
      builder: (_) => LikedCarListPage(
        user: user,
      ),
    );
  }

  static _initialize() {
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
      backgroundColor: AppTheme.colors['secondary']![100],
      appBar: customAppBar(
        title: 'Liked Cars',
        onPressed: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: SizedBox(
          height: size.height * 0.87,
          width: size.width,
          child: StreamBuilder(
              stream: likedCarsController.getLikedCars(user!.uid),
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
                    return CarDetailWidget(
                      name: carModelAtIndex.carName,
                      fuelAndType: carModelAtIndex.carFuelType,
                      image: carModelAtIndex.carImages[0],
                      width: size.width,
                      carRent: carModelAtIndex.carRentPricePerDay,
                      seatCapacity: carModelAtIndex.carSeatingCapacity,
                      onPressed: () {
                        Navigator.push(context,
                            CarDetailPage.route(user, carModelAtIndex));
                      },
                      tag: '${carModelAtIndex.carName}',
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
