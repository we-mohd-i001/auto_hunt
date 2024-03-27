import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../constants/strings/strings.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../vaahextendflutter/widgets/atoms/container_with_rounded_border.dart';
import '../common_widgets/learn_more_with_title.dart';
import '../common_widgets/my_custom_button.dart';
import '../rent_checkout/rent_checkout_page.dart';
import 'controller/car_detail_controller.dart';
import 'widgets/car_information_widget.dart';

class CarDetailPage extends StatelessWidget {
  final Map<String, dynamic>? data;
  const CarDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CarDetailController carDetailController = Get.put(CarDetailController());
    if (data != null) {
      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
              carDetailController.isImageOpened(false);
            },
          ),
          title: Text(data!['car_name']),
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
                              autoPlay: true,
                              viewportFraction: 1,
                              initialPage: 0,
                            ),
                            itemCount: data!['car_images'].length,
                            itemBuilder: (BuildContext context, int itemIndex,
                                    int pageViewIndex) =>
                                Hero(
                              tag: data!['car_name'],
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: PhotoView(
                                    backgroundDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    imageProvider: NetworkImage(
                                      data!['car_images'][itemIndex],
                                    ),
                                    filterQuality: FilterQuality.medium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                                const Text(
                                  Strings.carOwner,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                                verticalMargin4,
                                Row(
                                  children: [
                                    Image.network(
                                      data!['brand_logo'],
                                      height: 26,
                                      fit: BoxFit.contain,
                                    ),
                                    horizontalMargin4,
                                    Text(
                                      data!['car_brand'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            ButtonIcon(
                              onPressed: () {},
                              iconData: Icons.chat_rounded,
                              buttonType: ButtonType.primary,
                            )
                          ],
                        ),
                      ),
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
                              value: data!['car_range'],
                              size: size.width - 30,
                            ),
                            carInformationWidget(FontAwesomeIcons.gear,
                                informationType: Strings.enginePower,
                                value: data!['car_engine_power'],
                                size: size.width - 30),
                            carInformationWidget(FontAwesomeIcons.gauge,
                                informationType: Strings.maxTorque,
                                value: data!['car_max_torque'],
                                size: size.width - 30),
                          ],
                        ),
                      ),
                      Visibility(
                          visible:
                              carDetailController.areExtraDetailsVisible.value,
                          child: verticalMargin12),
                      Visibility(
                        visible:
                            carDetailController.areExtraDetailsVisible.value,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              carInformationWidget(
                                FontAwesomeIcons.gears,
                                informationType: Strings.transmission,
                                value: data!['car_transmission'],
                                size: size.width - 30,
                              ),
                              carInformationWidget(FontAwesomeIcons.peopleGroup,
                                  informationType: Strings.seatCapacity,
                                  value: data!['car_seating_capacity'],
                                  size: size.width - 30),
                              carInformationWidget(FontAwesomeIcons.carRear,
                                  informationType: Strings.wheelType,
                                  value: data!['car_wheel_type'],
                                  size: size.width - 30),
                            ],
                          ),
                        ),
                      ),
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
                                  data!['car_location'],
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            carDetailController.areExtraDetailsVisible.value,
                        child: const SizedBox(
                          height: 84,
                        ),
                      ),
                    ],
                  ),
                ),
                myCustomButton(
                    tag: 'hero-1',
                    onPressed: () {
                      Get.to(const RentCheckoutPage());
                    },
                    text: Strings.rentThisCar)
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
          body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No data found!'),
            ButtonTextWithIcon(
                onPressed: () {
                  Get.back();
                },
                text: 'Go back',
                iconData: Icons.arrow_back_rounded)
          ],
        ),
      ));
    }
  }
}
