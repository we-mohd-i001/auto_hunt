import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yourtasks/vaahextendflutter/helpers/constants.dart';
import 'package:yourtasks/vaahextendflutter/helpers/enums.dart';
import '../../../common_widgets/profile_picture_container.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../vaahextendflutter/widgets/atoms/input_text.dart';
import 'controller/profile_controller.dart';

class ProfileEditPage extends StatelessWidget {
  final dynamic data;
  static const String routePath = '/profile_edit';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const ProfileEditPage(),
    );
  }

  const ProfileEditPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            height: 460,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  profileController.profileImagePath.isEmpty
                      ? profilePictureContainer(
                          NetworkImage(data['imageUrl']),
                          44.0,
                        )
                      : profilePictureContainer(
                          FileImage(
                              File(profileController.profileImagePath.value)),
                          44.0,
                        ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonOutlinedWithIcon(
                          onPressed: () {
                            profileController.changeImage();
                          },
                          text: 'Change Profile Photo',
                          iconData: Icons.person),
                     horizontalMargin8,
                      profileController.isImageLoading.value ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator()):
                      ButtonIcon(onPressed: profileController.isDisabled.value ? (){
                        Get.snackbar('Image not Selected', 'Please Select an Image first.', colorText:Colors.red,backgroundColor: Colors.white);
                      } : () async{
                        profileController.isImageLoading(true);
                        if (profileController
                            .profileImagePath.value.isNotEmpty) {
                          await profileController.uploadProfileImage();
                        } else {
                          profileController.profileImageLink =
                          data['imageUrl'];
                        }
                        profileController.updateProfileImage(profileController.profileImageLink);

                      }, iconData: FontAwesomeIcons.check,
                      buttonType: profileController.isDisabled.value ? ButtonType.secondary : ButtonType.primary,
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Name',
                              style:
                                  TextStyle(color: AppTheme.colors['primary']),
                            )),
                        InputText(
                          controller: profileController.nameController,
                          label: 'Name',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Old Password',
                              style:
                                  TextStyle(color: AppTheme.colors['primary']),
                            )),
                        InputText(
                            isPassword:
                                profileController.passwordVisibility.value,
                            maxLines: 1,
                            controller: profileController.oldPassController,
                            label: 'Old Password',
                            suffixIcon:
                                profileController.passwordVisibility.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                            suffixOnTap: () =>
                                profileController.togglePasswordVisibility()),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'New Password',
                              style:
                                  TextStyle(color: AppTheme.colors['primary']),
                            )),
                        InputText(
                            isPassword:
                                profileController.passwordVisibility.value,
                            maxLines: 1,
                            controller: profileController.passwordController,
                            label: 'New Password',
                            suffixIcon:
                                profileController.passwordVisibility.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                            suffixOnTap: () =>
                                profileController.togglePasswordVisibility()),
                      ],
                    ),
                  ),
                  profileController.isLoading.value
                      ? const CircularProgressIndicator()
                      : ButtonOutlined(
                          onPressed: () async {
                            profileController.isLoading(true);

                            if (data['password'] ==
                                profileController.oldPassController.text) {
                              profileController.authPasswordChange(
                                  data['email'],
                                  profileController.oldPassController.text,
                                  profileController.passwordController.text);

                              await profileController.updateProfile(
                                  profileController.nameController.text,
                                  profileController.passwordController.text,
                                  );
                              Get.snackbar(
                                  'Success', 'Profile Update Complete', backgroundColor: Colors.white);
                            } else {
                              Get.snackbar('Password Incorrect',
                                  'The old password is incorrect! Please reenter the correct password.',  backgroundColor: Colors.white);
                              profileController.isLoading(false);
                            }
                          },
                          text: 'Save',
                          foregroundColor: AppTheme.colors['primary'],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
