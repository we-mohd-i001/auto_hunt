import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yourtasks/application/pages/home/controller/my_home_controller.dart';
import '../../../application/pages/login/login_page.dart';

import '../../../vaahextendflutter/helpers/enums.dart';
import '../../../vaahextendflutter/widgets/atoms/buttons.dart';

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
    var controller = Get.put(MyHomeController());

    var navBarItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 26), label: 'Home'),
      const BottomNavigationBarItem(icon: Icon(Icons.category_rounded, size: 26), label: 'Categories'),
      const BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_rounded, size: 26), label: 'Cart'),
      const BottomNavigationBarItem(icon: Icon(Icons.person_2_rounded, size: 26), label: 'Profile')
    ];

    var navBody = [
      Container(color: Colors.blue,),
      Container(color: Colors.amber,),
      Container(color: Colors.purpleAccent,),
      Container(color: Colors.cyanAccent,),




    ];
    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value),),),

        ],
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentNavIndex.value,
        items: navBarItems,
        selectedItemColor: Colors.red,
        unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w700
        ),
        selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w800
        ),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (value){
          controller.currentNavIndex.value = value;
        },
      ),),
    );
  }
}
