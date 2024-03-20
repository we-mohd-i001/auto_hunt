import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../common_widgets/profile_picture_container.dart';
import '../../../constants/others/other_consts.dart';
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
                  ButtonOutlinedWithIcon(
                      onPressed: () {
                        profileController.changeImage();
                      },
                      text: 'Change Profile Photo',
                      iconData: Icons.person),
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
                            if (profileController
                                .profileImagePath.value.isNotEmpty) {
                              await profileController.uploadProfileImage();
                            } else {
                              profileController.profileImageLink =
                                  data['imageUrl'];
                            }

                            if (data['password'] ==
                                profileController.oldPassController.text) {
                              profileController.authPasswordChange(
                                  data['email'],
                                  profileController.oldPassController.text,
                                  profileController.passwordController.text);

                              await profileController.updateProfile(
                                  profileController.nameController.text,
                                  profileController.passwordController.text,
                                  profileController.profileImageLink);
                              await Get.snackbar(
                                  'Success', 'Profile Update Complete');
                            } else {
                              Get.snackbar('Password Incorrect',
                                  'The old password is incorrect! Please reenter the password.');
                              profileController.isLoading(false);
                            }
                          },
                          text: 'Submit',
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
