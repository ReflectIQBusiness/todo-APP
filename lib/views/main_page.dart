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
    return PersistentTabView(
      context,
      controller: homeController.controller,
      screens: [
        ProfilePage(),
        HomePage(),
        AddPage(),
        ProgressPage(),
        HistoricPage(),
      ],
      items: homeController.navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
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
    );
  }
}
