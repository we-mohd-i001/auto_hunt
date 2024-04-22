import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../../controllers/main_navigator_controller.dart';
import '../../../controllers/profile_controller.dart';
import '../../../controllers/search_controller.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../controllers/brands_controller.dart';
import '../chat_list/chat_list_page.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';
import '../search/search_page.dart';

class MyHomePage extends StatelessWidget {
  static const String routePath = '/home';

  static Route<void> route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routePath),
      builder: (_) => const MyHomePage(),
    );
  }

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    BrandsController brandsController =
        Get.put(BrandsController(context: context));
    AuthController authController = Get.put(AuthController());
    ProfileController profileController = Get.put(ProfileController());
    MainNavigatorController mainNavigatorController =
        Get.put(MainNavigatorController());
    SearchCarsController searchCarsController = Get.put(SearchCarsController());
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser!;
    //ChatController chatController = Get.put(ChatController());

    List<BottomNavigationBarItem> navBarItems = [
      const BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded, size: 26),
          label: 'Home',
          tooltip: 'Home 1 of 4'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded, size: 26),
          label: 'Search',
          tooltip: 'Search 2 of 4'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.message_rounded, size: 26),
          label: 'Messages',
          tooltip: 'Messages 3 of 4'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person_2_rounded, size: 26),
          label: 'Profile',
          tooltip: 'Profile 4 of 4')
    ];
    List<Widget> pages = [
      HomePage(
        profileController: profileController,
        user: user,
      ),
      SearchPage(
        user: user,
      ),
      ChatListPage(
        user: user,
      ),
      const ProfilePage(),
    ];
    return Scaffold(
      backgroundColor: AppTheme.colors['secondary']![100],
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: pages
                  .elementAt(mainNavigatorController.currentNavIndex.value),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: mainNavigatorController.currentNavIndex.value,
          items: navBarItems,
          selectedItemColor: AppTheme.colors['primary'],
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w800),
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppTheme.colors['white'],
          onTap: (value) {
            mainNavigatorController.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
