import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:to_do_app/controllers/home_controller.dart';
import 'package:to_do_app/views/add_page.dart';
import 'package:to_do_app/views/historic_page.dart';
import 'package:to_do_app/views/home_page.dart';
import 'package:to_do_app/views/profile_page.dart';
import 'package:to_do_app/views/progress_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final HomeController homeController = Get.isRegistered<HomeController>() ? Get.find<HomeController>() : Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PersistentTabView(
        context,
        controller: homeController.controller.value,
        onItemSelected: (index) {
          homeController.controller.refresh();
        },
        screens: [
          const ProfilePage(),
          HomePage(),
          const AddPage(),
          const ProgressPage(),
          const HistoricPage(),
        ],
        items: homeController.navBarsItems(),

        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(20.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );
  }
}
