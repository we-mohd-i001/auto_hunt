// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:yourtasks/controllers/profile_controller.dart';

import '../../../constants/constants.dart';
import '../../../constants/others/other_consts.dart';
import '../../../controllers/home_controller.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/constants.dart';
import '../brands_detail/view_states/error_state_view.dart';
import '../common_widgets/learn_more_with_title.dart';
import 'widgets/home_screen_options.dart';
import 'widgets/location_and_profile.dart';
import 'widgets/most_popular_cars.dart';
import 'widgets/search_by_brands.dart';
import 'widgets/search_widget.dart';

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
    HomeController homeController = Get.put(HomeController());
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
                        return Column(
                          children: [
                            locationAndProfile(
                                image: !snapshot.hasData
                                    ? OtherConsts.profilePlaceHolder
                                    : snapshot.data!.docs[0]['imageUrl']),
                            searchWidget(),
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
                searchByBrands(size: size, theUser: theUser),
                learnMoreWithTitle(Strings.mostPopularCars),
                Obx(() {
                  if (homeController.isLoading.value) {
                    return const SizedBox(
                        height: 280,
                        width: double.infinity,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (homeController.isError.value) {
                    return const ErrorStateView();
                  } else if (homeController.carList.isEmpty) {
                    return emptyWidget;
                  }
                  return mostPopularCars(
                      carList: homeController.carList,
                      size: size,
                      theUser: theUser);
                }),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
