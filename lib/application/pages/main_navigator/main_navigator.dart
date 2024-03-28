import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../vaahextendflutter/app_theme.dart';
import '../../../controllers/brands_controller.dart';
import '../home/home_page.dart';
import '../../../controllers/auth_controller.dart';
import '../profile/profile_page.dart';
import '../../../controllers/main_navigator_controller.dart';

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
    MyHomeController controller = Get.put(MyHomeController());

    List<BottomNavigationBarItem> navBarItems = [
      const BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded, size: 26), label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.category_rounded, size: 26), label: 'Brands'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.message_rounded, size: 26), label: 'Messages'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person_2_rounded, size: 26), label: 'Profile')
    ];

    List<Widget> pages = [
      const HomePage(),
      Container(color: Colors.amber),
      Container(color: Colors.purpleAccent),
      const ProfilePage(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: pages.elementAt(controller.currentNavIndex.value),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          items: navBarItems,
          selectedItemColor: AppTheme.colors['primary'],
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w800),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
