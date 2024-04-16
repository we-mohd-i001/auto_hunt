import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../helpers/constants/strings/strings.dart';
import '../../../controllers/brand_detail_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../controllers/search_controller.dart';
import '../../../models/car/car_model.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../../../helpers/commons.dart';
import '../chat/chat_page.dart';
import '../common_widgets/learn_more_with_title.dart';
import '../common_widgets/my_custom_button.dart';
import '../rent_checkout/rent_checkout_page.dart';
import '../../../controllers/car_detail_controller.dart';
import 'widgets/car_information_widget.dart';

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
      appBar: AppBar(
        backgroundColor: AppTheme.colors['secondary']![100],
        surfaceTintColor: AppTheme.colors['secondary']![100],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: Strings.back,
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
        ),
        actions: [
          Obx(() => IconButton(
                tooltip: carDetailController.isCarLiked.value
                    ? Strings.unlike
                    : Strings.like,
                icon: Icon(
                    carDetailController.isCarLiked.value
                        ? Icons.favorite
                        : Icons.favorite_outline_rounded,
                    color: carDetailController.isCarLiked.value
                        ? AppTheme.colors['danger']
                        : AppTheme.colors['black']),
                onPressed: carDetailController.isCarLiked.value
                    ? () {
                        carDetailController.isCarLiked(false);
                        carDetailController.removeFromLikedCarsList(
                            carId: carModel.id, currentId: user!.uid);
                      }
                    : () {
                        carDetailController.isCarLiked(true);
                        carDetailController.addToLikedCarsList(
                            carId: carModel.id, currentId: user!.uid);
                      },
              ))
        ],
        title: Text(
          '${carModel.carName}',
          style: heading,
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    verticalMargin8,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                            autoPlay: false,
                            viewportFraction: 1,
                            initialPage: 0,
                          ),
                          itemCount: carModel.carImages.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Stack(
                              children: [
                                Hero(
                                  tag: '${carModel.carName}',
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: PhotoView(
                                      backgroundDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      imageProvider: NetworkImage(
                                        carModel.carImages[itemIndex],
                                      ),
                                      filterQuality: FilterQuality.medium,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ContainerWithRoundedBorder(
                                    color: AppTheme.colors['secondary']![50]
                                        as Color,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 4),
                                    borderRadius: 6,
                                    child: Text(
                                      '${itemIndex + 1}',
                                      style: normal,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible:
                            !carDetailController.areExtraDetailsVisible.value,
                        child: verticalMargin24),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Strings.carOwner, style: small),
                              verticalMargin4,
                              Row(
                                children: [
                                  Image.network(
                                    carModel.brandLogo.toString(),
                                    height: 26,
                                    fit: BoxFit.contain,
                                  ),
                                  horizontalMargin4,
                                  Text(
                                    '${carModel.carBrand}',
                                    style: subheadingBlack,
                                  ),
                                ],
                              )
                            ],
                          ),
                          ButtonIcon(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  ChatPage.route(
                                      carModel.carOwner, carModel.carOwnerId));
                            },
                            iconData: Icons.chat_rounded,
                            buttonType: ButtonType.primary,
                          )
                        ],
                      ),
                    ),
                    Visibility(
                        visible:
                            !carDetailController.areExtraDetailsVisible.value,
                        child: verticalMargin24),
                    GestureDetector(
                      onTap: () {
                        carDetailController.toggleAreExtraDetailsVisible();
                      },
                      child: learnMoreWithTitle(Strings.carInfo,
                          changeLearnMore: Strings.viewDetail),
                    ),
                    verticalMargin12,
                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          carInformationWidget(
                            FontAwesomeIcons.road,
                            informationType: Strings.carRange,
                            value: '${carModel.carRange}',
                            size: size.width - 30,
                          ),
                          carInformationWidget(FontAwesomeIcons.gear,
                              informationType: Strings.enginePower,
                              value: '${carModel.carEnginePower}',
                              size: size.width - 30),
                          carInformationWidget(FontAwesomeIcons.gauge,
                              informationType: Strings.maxTorque,
                              value: '${carModel.carMaxTorque}',
                              size: size.width - 30),
                        ],
                      ),
                    ),
                    Visibility(
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
                            carInformationWidget(
                              FontAwesomeIcons.gears,
                              informationType: Strings.transmission,
                              value: '${carModel.carTransmission}',
                              size: size.width - 30,
                            ),
                            carInformationWidget(FontAwesomeIcons.peopleGroup,
                                informationType: Strings.seatCapacity,
                                value: '${carModel.carSeatingCapacity}',
                                size: size.width - 30),
                            carInformationWidget(FontAwesomeIcons.carRear,
                                informationType: Strings.wheelType,
                                value: '${carModel.carWheelType}',
                                size: size.width - 30),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible:
                            !carDetailController.areExtraDetailsVisible.value,
                        child: verticalMargin24),
                    learnMoreWithTitle(Strings.carLocation,
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
                      visible: carDetailController.areExtraDetailsVisible.value,
                      child: const SizedBox(
                        height: 84,
                      ),
                    ),
                  ],
                ),
              ),
              myCustomButton(
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
