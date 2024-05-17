import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/search/search_controller.dart';
import '../../../models/car/car_model.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/widgets/atoms/input_text.dart';
import '../../../helpers/commons.dart';
import '../car_detail/car_detail_page.dart';
import '../common_widgets/car_detail_widget.dart';

class SearchPage extends StatelessWidget {
  final User? user;
  const SearchPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SearchCarsController searchCarsController =
        Get.find<SearchCarsController>();
    return Scaffold(
      backgroundColor: AppTheme.colors['secondary']![100],
      appBar: AppBar(
        backgroundColor: AppTheme.colors['secondary']![100],
        surfaceTintColor: AppTheme.colors['secondary']![100],
        automaticallyImplyLeading: false,
        title: Padding(
          padding: horizontalPadding12,
          child: InputText(
            controller: searchCarsController.searchTextController,
            label: 'Search cars...',
            suffixIcon: Icons.search,
            onChanged: (value) {
              searchCarsController.getCarList(keyword: value.toLowerCase());
              searchCarsController.fetchPost();
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
              CarModel carModelAtIndex = searchCarsController.carList[index];
              return CarDetailWidget(
                  name: carModelAtIndex.carName,
                  fuelAndType: carModelAtIndex.carFuelType,
                  image: carModelAtIndex.carImages[0],
                  width: size.width,
                  carRent: carModelAtIndex.carRentPricePerDay,
                  seatCapacity: carModelAtIndex.carSeatingCapacity,
                  onPressed: () {
                    Navigator.push(
                        context, CarDetailPage.route(user, carModelAtIndex));
                  },
                  tag: '${carModelAtIndex.carName}');
            },
          );
        }
      }),
    );
  }
}
