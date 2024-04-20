import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../helpers/constants/strings/strings.dart';
import '../../../controllers/brand_detail_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/search_controller.dart';
import '../../../models/car/car_model.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../helpers/commons.dart';
import '../chat/chat_page.dart';
import '../common_widgets/custom_appbar.dart';
import '../common_widgets/learn_more_with_title.dart';
import '../common_widgets/my_custom_button.dart';
import '../rent_checkout/rent_checkout_page.dart';
import '../../../controllers/car_detail_controller.dart';
import 'widgets/car_information_widget.dart';
import 'widgets/carousel_image_car.dart';
import 'widgets/like_button.dart';
import 'widgets/message_button.dart';
import 'widgets/owner_detail_widget.dart';

class CarDetailPage extends StatelessWidget {
  final User? user;
  final CarModel carModel;
  const CarDetailPage({super.key, required this.carModel, required this.user});

  static Route<void> route(User? user, CarModel carModel) {
    initializeController(user, carModel);
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/details'),
      builder: (_) => CarDetailPage(
        carModel: carModel,
        user: user,
      ),
    );
  }

  static initializeController(User? user, CarModel carModel) {
    return Get.isRegistered<CarDetailController>()
        ? Get.find<CarDetailController>()
        : Get.put(
            CarDetailController(
              carLikedList: carModel.carLiked,
              user: user,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CarDetailController carDetailController = Get.find<CarDetailController>();
    return Scaffold(
      backgroundColor: AppTheme.colors['secondary']![100],
      appBar: customAppBar(
        onPressed: () {
          Navigator.pop(context);
          Get.delete<CarDetailController>();
          Get.find<HomeController>().fetchMostPopularCarList();
          Get.find<BrandDetailController>()
              .fetchCarList(carModel.carBrand.toString());
          SearchCarsController searchCarsController =
              Get.find<SearchCarsController>();
          searchCarsController.getCarList(
              keyword: searchCarsController.searchTextController.text);
          carDetailController.isImageOpened(false);
        },
        title: '${carModel.carName}',
        actions: [
          Obx(
            () => LikeButton(
              isCarLiked: carDetailController.isCarLiked.value,
              onPressedToLike: () {
                carDetailController.isCarLiked(true);
                carDetailController.addToLikedCarsList(
                    carId: carModel.id, currentId: user!.uid);
              },
              onPressedToUnlike: () {
                carDetailController.isCarLiked(false);
                carDetailController.removeFromLikedCarsList(
                    carId: carModel.id, currentId: user!.uid);
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    verticalMargin8,
                    CarouselImageCar(
                      heroTag: '${carModel.carName}',
                      carImagesList: carModel.carImages,
                    ),
                    Visibility(
                        // condition dependent vertical margin
                        visible:
                            !carDetailController.areExtraDetailsVisible.value,
                        child: verticalMargin24),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OwnerDetailWidget(
                            logoUrl: carModel.brandLogo.toString(),
                            ownerName: '${carModel.carBrand}',
                          ),
                          MessageButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  ChatPage.route(
                                      carModel.carOwner, carModel.carOwnerId));
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                        // condition dependent vertical margin
                        visible:
                            !carDetailController.areExtraDetailsVisible.value,
                        child: verticalMargin24),
                    GestureDetector(
                      onTap: () {
                        carDetailController.toggleAreExtraDetailsVisible();
                      },
                      child: const LearnMoreWithTitle(
                          title: Strings.carInfo,
                          changeLearnMore: Strings.viewDetail),
                    ),
                    verticalMargin12,
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CarInformationWidget(
                            icon: FontAwesomeIcons.road,
                            informationType: Strings.carRange,
                            value: '${carModel.carRange}',
                            size: size.width - 30,
                          ),
                          CarInformationWidget(
                              icon: FontAwesomeIcons.gear,
                              informationType: Strings.enginePower,
                              value: '${carModel.carEnginePower}',
                              size: size.width - 30),
                          CarInformationWidget(
                              icon: FontAwesomeIcons.gauge,
                              informationType: Strings.maxTorque,
                              value: '${carModel.carMaxTorque}',
                              size: size.width - 30),
                        ],
                      ),
                    ),
                    Visibility(
                        // condition dependent vertical margin
                        visible:
                            carDetailController.areExtraDetailsVisible.value,
                        child: verticalMargin12),
                    Visibility(
                      visible: carDetailController.areExtraDetailsVisible.value,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CarInformationWidget(
                              icon: FontAwesomeIcons.gears,
                              informationType: Strings.transmission,
                              value: '${carModel.carTransmission}',
                              size: size.width - 30,
                            ),
                            CarInformationWidget(
                                icon: FontAwesomeIcons.peopleGroup,
                                informationType: Strings.seatCapacity,
                                value: '${carModel.carSeatingCapacity}',
                                size: size.width - 30),
                            CarInformationWidget(
                                icon: FontAwesomeIcons.carRear,
                                informationType: Strings.wheelType,
                                value: '${carModel.carWheelType}',
                                size: size.width - 30),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        // condition dependent vertical margin
                        visible:
                            !carDetailController.areExtraDetailsVisible.value,
                        child: verticalMargin24),
                    const LearnMoreWithTitle(
                        title: Strings.carLocation,
                        changeLearnMore: Strings.distance),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: ContainerWithRoundedBorder(
                        child: Row(
                          children: [
                            const Icon(FontAwesomeIcons.locationCrosshairs),
                            horizontalMargin4,
                            Flexible(
                              child: Text(
                                '${carModel.carLocation}',
                                style: normal,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      // condition dependent vertical margin
                      visible: carDetailController.areExtraDetailsVisible.value,
                      child: const SizedBox(
                        height: 84,
                      ),
                    ),
                  ],
                ),
              ),
              MyCustomButton(
                  type: ButtonType.primary,
                  tag: 'hero-1',
                  onPressed: () {
                    Navigator.push(context, RentCheckoutPage.route(carModel));
                  },
                  text: Strings.rentThisCar)
            ],
          ),
        ),
      ),
    );
  }
}
