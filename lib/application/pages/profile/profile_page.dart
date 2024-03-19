import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourtasks/application/pages/profile/profile_edit_page.dart';
import '../../../constants/others/other_consts.dart';
import '../login/controller/auth_controller.dart';
import '../login/login_page.dart';
import 'widgets/edit_profile_button.dart';
import 'widgets/liked_and_ordered_cars.dart';
import 'widgets/navigator_widget_to_orders_and_liked.dart';
import 'widgets/profile_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),
          child: Column(
            children: [
              editProfileButton(() {
                Get.toNamed(ProfileEditPage.routePath);
              }),
              profileData(
                OtherConsts.profileImageUrl,
                'Imran',
                'hunt@autohunt.com',
                () async {
                  await authController.signOutMethod();
                  authController.isLoading(false);
                  Get.offAllNamed(LoginPage.routePath);
                },
              ),
              const SizedBox(height: 20),
              likedAndOrderedCars(),
              const SizedBox(height: 20),
              navigatorWidgetToOrdersAndLiked()
            ],
          ),
        ),
      ),
    );
  }
}
