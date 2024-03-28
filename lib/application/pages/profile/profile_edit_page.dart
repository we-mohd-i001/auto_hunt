import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yourtasks/vaahextendflutter/helpers/constants.dart';
import 'package:yourtasks/vaahextendflutter/helpers/enums.dart';
import '../common_widgets/profile_picture_container.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/alerts.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../vaahextendflutter/widgets/atoms/input_text.dart';
import '../../../controllers/profile_controller.dart';

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
    ProfileController profileController = Get.find<ProfileController>();

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonOutlinedWithIcon(
                          onPressed: () {
                            profileController.changeImage();
                          },
                          text: 'Change Profile Photo',
                          iconData: Icons.person),
                      horizontalMargin8,
                      profileController.isImageLoading.value
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator())
                          : ButtonIcon(
                              onPressed: profileController
                                      .isImageUploadButtonDisabled.value
                                  ? () {
                                      Alerts.showInfoToast!(
                                          content: 'Please select an image.');
                                    }
                                  : () async {
                                      profileController.isImageLoading(true);
                                      if (profileController
                                          .profileImagePath.value.isNotEmpty) {
                                        await profileController
                                            .uploadProfileImage();
                                      } else {
                                        profileController.profileImageLink =
                                            data['imageUrl'];
                                      }
                                      profileController.updateProfileImage(
                                          profileController.profileImageLink);
                                    },
                              iconData: FontAwesomeIcons.check,
                              buttonType: profileController
                                      .isImageUploadButtonDisabled.value
                                  ? ButtonType.secondary
                                  : ButtonType.primary,
                            ),
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
                            style: TextStyle(
                              color: AppTheme.colors['primary'],
                            ),
                          ),
                        ),
                        InputText(
                          suffixIconColor:
                              profileController.isNameSuffixIconDisabled.value
                                  ? AppTheme.colors['secondary']
                                  : AppTheme.colors['primary'],
                          suffixIcon: FontAwesomeIcons.check,
                          suffixOnTap:
                              profileController.isNameSuffixIconDisabled.value
                                  ? () {
                                      Alerts.showErrorToast!(
                                          content:
                                              'Please change your name to update name!');
                                    }
                                  : () async {
                                      String name =
                                          profileController.nameController.text;
                                      await profileController.updateName(name);
                                      Alerts.showSuccessToast!(
                                          content:
                                          'Name updated.');
                                    },
                          controller: profileController.nameController,
                          onChanged: (_){profileController.isNameSuffixIconDisabled(false);},
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
                              style: TextStyle(
                                color: AppTheme.colors['primary'],
                              ),
                            )),
                        InputText(
                          isPassword: profileController.isPasswordVisible.value,
                          maxLines: 1,
                          controller: profileController.oldPassController,
                          label: 'Old Password',
                          suffixIcon: profileController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixOnTap: () =>
                              profileController.togglePasswordVisibility(),
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
                            'New Password',
                            style: TextStyle(
                              color: AppTheme.colors['primary'],
                            ),
                          ),
                        ),
                        InputText(
                          isPassword: profileController.isPasswordVisible.value,
                          maxLines: 1,
                          controller: profileController.passwordController,
                          label: 'New Password',
                          suffixIcon: profileController.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          suffixOnTap: () =>
                              profileController.togglePasswordVisibility(),
                        ),
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
                              profileController.changeAuthPassword(
                                  data['email'],
                                  profileController.oldPassController.text,
                                  profileController.passwordController.text);

                              await profileController.updatePassword(
                                profileController.passwordController.text,
                              );
                              Alerts.showSuccessToast!(
                                  content: 'Password updated.');
                            } else {
                              Alerts.showErrorToast!(
                                  content: 'Password Incorrect.');
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
