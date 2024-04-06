import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../controllers/liked_cars_controller.dart';
import '../../../data/car/car_model.dart';
import '../../../views/pages/ui/components/commons.dart';
import '../car_detail/car_detail_page.dart';
import '../common_widgets/car_bio.dart';

class LikedCarListpage extends StatelessWidget {
  final User? theUser;
  const LikedCarListpage({
    super.key,
    required this.theUser,
  });
  @override
  Widget build(BuildContext context) {
    LikedCarsController likedCarsController = Get.put(LikedCarsController());
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
              stream: likedCarsController.getLikedCarsList(theUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<CarModel>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('Liked cars will appear here!', style: normal),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    CarModel carIndex = snapshot.data!.docs[index].data.call();
                    return carBio(
                      carIndex.carName,
                      carIndex.carFuelType,
                      carIndex.carImages[0],
                      size.width,
                      carIndex.carRentPricePerDay,
                      carIndex.carSeatingCapacity,
                      () {
                        Get.to(
                          () => CarDetailPage(
                            data: carIndex,
                            theUser: theUser,
                          ),
                        );
                      },
                      '${carIndex.carName}',
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
