import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/cart_screen/controller/cart_controller.dart';
import 'package:scotch/view/screens/bottom_nav_bar/controller/bottom_nav_controller.dart';
import 'package:badges/badges.dart' as badges;

class BottomNavBar extends GetView<BottomNavController> {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController());
    BottomNavController bottomNavController = Get.put(BottomNavController());

    return Scaffold(
      body: GetBuilder<BottomNavController>(
        builder: (controller) {
          return bottomNavController.pages[controller.currentIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<BottomNavController>(
        builder: (controller) {
          return Container(
            decoration: const BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.size.width * 0.05,
                vertical: Get.size.height * 0.015,
              ),
              child: GNav(
                tabs: [
                  const GButton(
                    icon: Icons.home_outlined,
                    iconSize: 30,
                  ),
                  GButton(
                    icon: Icons.shopping_cart_outlined,
                    leading: GetBuilder<CartController>(
                      builder: (controller) {
                        return badges.Badge(
                          position:
                              badges.BadgePosition.topEnd(top: -17, end: -13),
                          badgeContent: Text(
                            cartController.totalproductCount.toString(),
                            style: const TextStyle(
                              color: kWhitecolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Icon(Icons.shopping_cart_outlined,
                              color: bottomNavController.currentIndex == 1
                                  ? lightThemeColor
                                  : kWhitecolor,
                              size: 30),
                        );
                      },
                    ),
                    iconSize: 30,
                  ),
                  const GButton(
                    icon: Icons.favorite_border_outlined,
                    iconSize: 30,
                  ),
                  const GButton(
                    icon: Icons.person_outline,
                    iconSize: 30,
                  ),
                ],
                backgroundColor: themeColor,
                color: kWhitecolor,
                activeColor: lightThemeColor,
                tabBackgroundColor: kWhitecolor,
                padding: const EdgeInsets.all(10),
                curve: Curves.bounceIn,
                selectedIndex: controller.currentIndex,
                onTabChange: (index) {
                  controller.bottomNav(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
