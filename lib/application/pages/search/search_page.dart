import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/search_controller.dart';
import '../../../data/car/car_model.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/widgets/atoms/input_text.dart';
import '../../../views/pages/ui/components/commons.dart';
import '../car_detail/car_detail_page.dart';
import '../common_widgets/car_bio.dart';

class SearchPage extends StatelessWidget {
  final User? theUser;
  const SearchPage({super.key, required this.theUser});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SearchCarsController searchCarsController =
        Get.find<SearchCarsController>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: horizontalPadding12,
          child: InputText(
            controller: searchCarsController.searchTextController,
            label: 'Search cars...',
            suffixIcon: Icons.search,
            onChanged: (value) {
              searchCarsController.getCarList(keyword: value.toLowerCase());
            },
          ),
        ),
      ),
      body: Obx(() {
        if (searchCarsController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (searchCarsController.isError.value) {
          return Center(
            child: Text(
              'Error!',
              style: normal,
            ),
          );
        } else if (searchCarsController.carList.isEmpty &&
            searchCarsController.searchTextController.text.isEmpty) {
          return Center(
            child: Text(
              'Start searching!',
              style: normal,
            ),
          );
        } else if (searchCarsController.carList.isEmpty) {
          return Center(
            child: Text(
              'No cars found with keyword "${searchCarsController.searchTextController.text}"',
              style: normal,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: searchCarsController.carList.length,
            itemBuilder: (context, index) {
              CarModel carIndex = searchCarsController.carList[index];
              return carBio(
                  carIndex.carName,
                  carIndex.carFuelType,
                  carIndex.carImages[0],
                  size.width,
                  carIndex.carRentPricePerDay,
                  carIndex.carSeatingCapacity, () {
                Get.to(CarDetailPage(data: carIndex, theUser: theUser));
              }, '${carIndex.carName}');
            },
          );
        }
      }),
    );
  }
}
