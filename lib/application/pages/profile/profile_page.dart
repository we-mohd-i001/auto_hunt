import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourtasks/vaahextendflutter/helpers/constants.dart';
import '../../../common_widgets/profile_picture_container.dart';
import '../../../constants/consts.dart';
import '../../../services/firestore_services.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../login/controller/auth_controller.dart';
import '../login/login_page.dart';
import 'controller/profile_controller.dart';
import 'profile_edit_page.dart';
import 'widgets/edit_profile_button.dart';
import 'widgets/liked_and_ordered_cars.dart';
import 'widgets/navigator_widget_to_orders_and_liked.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var profileController = Get.put(ProfileController());
    var authController = Get.find<AuthController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: FireStoreServices.getUser(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return
            const Center(child: CircularProgressIndicator(),);
          } else{
            var data = snapshot.data!.docs[0];
            return SafeArea(
              child: Padding(
                padding:
                const EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),
                child: Obx( () =>
                    Column(
                      children: [
                        editProfileButton(() {
                          profileController.nameController.text = data['name'];

                          Get.to(() => ProfileEditPage(data: data,));
                        }),
                        Row(
                          children: [
                            profilePictureContainer(
                                profileController.profileImagePath.isNotEmpty
                                    ? FileImage(
                                    File(profileController.profileImagePath.value))
                                    : NetworkImage(data['imageUrl']),
                                28.0),
                            horizontalMargin8,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${data['name']}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${data['email']}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const Spacer(),
                            ButtonOutlinedWithIcon(
                              iconData: Icons.logout_rounded,
                              text: 'Log Out',
                              onPressed: () async {
                                await authController.signOutMethod();
                                authController.isLoading(false);
                                Get.offAllNamed(LoginPage.routePath);
                              },
                            ),
                          ],
                        ),
                        verticalMargin16,
                        verticalMargin4,
                        likedAndOrderedCars('${data['liked_cars_count']}',
                            '${data['order_count']}'),
                        verticalMargin24,
                        verticalMargin2,
                        navigatorWidgetToOrdersAndLiked()
                      ],
                    ),
                ),
              ),
            );
          }
        },
      )
    );
  }
}
