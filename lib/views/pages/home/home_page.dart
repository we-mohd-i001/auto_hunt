import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/constants.dart';
import '../../../helpers/constants/others/other_consts.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/liked_cars_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../controllers/user_location_controller.dart';
import '../../../models/car/car_model.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../car_detail/car_detail_page.dart';
import '../common_widgets/car_detail_widget.dart';
import '../common_widgets/learn_more_with_title.dart';
import '../../../helpers/commons.dart';
import 'widgets/home_screen_options.dart';
import 'widgets/location_and_profile.dart';
import 'widgets/most_popular_cars.dart';
import 'widgets/search_by_brands.dart';

class HomePage extends StatelessWidget {
  final ProfileController profileController;
  final User? user;
  const HomePage({
    Key? key,
    required this.profileController,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserLocationController userLocationController =
        Get.put(UserLocationController());
    HomeController homeController = Get.put(HomeController());
    LikedCarsController likedCarsController = Get.put(LikedCarsController());
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AppTheme.colors['secondary']![100],
      width: size.width,
      height: size.height,
      child: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              leading: null,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: AppTheme.colors['black'],
                  child: StreamBuilder(
                      stream: profileController.updateUiImageUrl(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('Error!', style: normal),
                          );
                        }
                        return Column(
                          children: [
                            Obx(
                              () => locationAndProfile(
                                  image: !snapshot.hasData
                                      ? OtherConsts.profilePlaceHolder
                                      : snapshot.data!.docs[0]['imageUrl'],
                                  location: userLocationController
                                      .currentLocation.value,
                                  onPressedRefreshIcon: () {
                                    userLocationController.update();
                                  }),
                            ),
                            verticalMargin8,
                            const Expanded(child: HomeScreenOptions()),
                          ],
                        );
                      }),
                ),
              ),
              expandedHeight: 230,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                const LearnMoreWithTitle(title: Strings.searchByBrand),
                SearchByBrands(size: size, user: user),
                const LearnMoreWithTitle(title: Strings.mostPopularCars),
                Obx(() {
                  if (homeController.isLoading.value) {
                    return const SizedBox(
                        height: 280,
                        width: double.infinity,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (homeController.isError.value) {
                    return Scaffold(
                        backgroundColor: AppTheme.colors['secondary']![100],
                        body: Center(
                          child: Text('Something went Wrong!', style: normal),
                        ));
                  } else if (homeController.carList.isEmpty) {
                    return emptyWidget;
                  }
                  return MostPopularCars(
                    carList: homeController.carList,
                    size: size,
                    user: user,
                  );
                }),
                Obx(
                  () => likedCarsController.isLikedCarEmpty.value
                      ? emptyWidget
                      : const LearnMoreWithTitle(title: Strings.likedCars),
                ),
                StreamBuilder(
                    stream: likedCarsController.getLikedCarsList(user!.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<CarModel>> snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox(
                          height: 280,
                          width: double.infinity,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return emptyWidget;
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                          height: 260,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              CarModel carModel =
                                  snapshot.data!.docs[index].data.call();
                              return CarDetailWidget(
                                name: carModel.carName,
                                fuelAndType: carModel.carFuelType,
                                image: carModel.carImages[0],
                                width: 200.0,
                                carRent: carModel.carRentPricePerDay,
                                seatCapacity: carModel.carSeatingCapacity,
                                onPressed: () {
                                  Navigator.push(context,
                                      CarDetailPage.route(user, carModel));
                                },
                                tag: '${carModel.carImages[0]}',
                              );
                            },
                          ),
                        ),
                      );
                    }),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
