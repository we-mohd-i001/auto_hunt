import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yourtasks/constants/others/other_consts.dart';
import 'package:yourtasks/vaahextendflutter/helpers/constants.dart';
import 'package:yourtasks/vaahextendflutter/widgets/atoms/buttons.dart';
import 'package:yourtasks/vaahextendflutter/widgets/atoms/input_text.dart';

import '../../../vaahextendflutter/app_theme.dart';

class ProfileEditPage extends StatelessWidget {
  static const String routePath = '/profile_edit';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const ProfileEditPage(),
    );
  }

  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            height: 360,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Hero(
                  tag: 'edit-profile',
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(OtherConsts.profileImageUrl),
                  ),
                ),
                ButtonOutlinedWithIcon(onPressed: (){}, text: 'Change Profile Photo', iconData: Icons.person),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: InputText(
                    label: 'Name',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: InputText(
                    label: 'Password',
                  ),
                ),
                ButtonOutlined(onPressed: (){}, text: 'Submit', foregroundColor: AppTheme.colors['primary'],),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
