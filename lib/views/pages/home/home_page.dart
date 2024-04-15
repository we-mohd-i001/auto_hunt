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
import '../common_widgets/car_bio.dart';
import '../common_widgets/learn_more_with_title.dart';
import '../ui/components/commons.dart';
import 'widgets/home_screen_options.dart';
import 'widgets/location_and_profile.dart';
import 'widgets/most_popular_cars.dart';
import 'widgets/search_by_brands.dart';

class HomePage extends StatelessWidget {
  final ProfileController profileController;
  final User? theUser;
  const HomePage({
    Key? key,
    required this.profileController,
    required this.theUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserLocationController userLocationController =
        Get.put(UserLocationController());
    HomeController homeController = Get.put(HomeController());
    LikedCarsController likedCarsController = Get.put(LikedCarsController());
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey.shade100,
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
                            // const SizedBox(
                            //   width: 300,
                            //   child: InputText(
                            //     label: 'Search cars...',
                            //   ),
                            // ),
                            verticalMargin8,
                            Expanded(child: homeScreenOptions()),
                          ],
                        );
                      }),
                ),
              ),
              expandedHeight: 230,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                learnMoreWithTitle(Strings.searchByBrand),
                searchByBrands(size: size, user: theUser),
                learnMoreWithTitle(Strings.mostPopularCars),
                Obx(() {
                  if (homeController.isLoading.value) {
                    return const SizedBox(
                        height: 280,
                        width: double.infinity,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (homeController.isError.value) {
                    return Scaffold(
                        body: Center(
                      child: Text('Something went Wrong!', style: normal),
                    ));
                  } else if (homeController.carList.isEmpty) {
                    return emptyWidget;
                  }
                  return mostPopularCars(
                      carList: homeController.carList,
                      size: size,
                      theUser: theUser);
                }),
                Obx(
                  () => likedCarsController.isLikedCarEmpty.value
                      ? emptyWidget
                      : learnMoreWithTitle(Strings.likedCars),
                ),
                StreamBuilder(
                    stream: likedCarsController.getLikedCarsList(theUser!.uid),
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
                              CarModel carIndex =
                                  snapshot.data!.docs[index].data.call();
                              return carDetailWidget(
                                carIndex.carName,
                                carIndex.carFuelType,
                                carIndex.carImages[0],
                                200.0,
                                carIndex.carRentPricePerDay,
                                carIndex.carSeatingCapacity,
                                () {
                                  // Get.to(
                                  //   () => CarDetailPage(
                                  //     data: carIndex,
                                  //     theUser: theUser,
                                  //   ),
                                  // );

                                  Navigator.push(context,
                                      CarDetailPage.route(theUser, carIndex));
                                },
                                '${carIndex.carImages[0]}',
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
