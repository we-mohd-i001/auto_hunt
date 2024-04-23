import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../vaahextendflutter/helpers/constants.dart';
import '../../../vaahextendflutter/helpers/enums.dart';
import '../common_widgets/custom_appbar.dart';
import '../common_widgets/profile_picture_container.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../vaahextendflutter/helpers/alerts.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';
import '../../../vaahextendflutter/widgets/atoms/input_text.dart';
import '../../../controllers/profile/profile_controller.dart';
import '../../../helpers/commons.dart';

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
      backgroundColor: AppTheme.colors['secondary']![100],
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(
        title: 'Edit Profile',
        onPressed: () {
          Get.back();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            height: 520,
            decoration: BoxDecoration(
              color: AppTheme.colors['white'],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  profileController.profileImagePath.isEmpty
                      ? ProfilePictureWidget(
                          image: NetworkImage(data['imageUrl']),
                          radius: 44.0,
                        )
                      : ProfilePictureWidget(
                          image: FileImage(
                              File(profileController.profileImagePath.value)),
                          radius: 44.0,
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
                                        profileController
                                                .profileImageLinkFromFirebaseStorage =
                                            data['imageUrl'];
                                      }
                                      profileController.updateProfileImage(
                                          profileController
                                              .profileImageLinkFromFirebaseStorage);
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
                          child: Text('Change Name', style: subheading),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Name',
                            style: normalPrimary,
                          ),
                        ),
                        InputText(
                          suffixIconColor: profileController
                                  .isNameTextFieldIconButtonDisabled.value
                              ? AppTheme.colors['secondary']
                              : AppTheme.colors['primary'],
                          suffixIcon: FontAwesomeIcons.check,
                          suffixOnTap: profileController
                                  .isNameTextFieldIconButtonDisabled.value
                              ? () {
                                  Alerts.showInfoToast!(
                                      content:
                                          'Please change your name to update name!');
                                }
                              : () async {
                                  String name =
                                      profileController.nameController.text;
                                  await profileController.updateName(name);
                                  Alerts.showSuccessToast!(
                                      content: 'Name updated.');
                                },
                          controller: profileController.nameController,
                          onChanged: (_) {
                            profileController
                                .isNameTextFieldIconButtonDisabled(false);
                          },
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
                          child: Text('Change Password', style: subheading),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text('Old Password', style: normalPrimary)),
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
                          child: Text('New Password', style: normalPrimary),
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
                          text: 'Update Password',
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
