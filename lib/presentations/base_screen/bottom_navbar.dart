import 'package:fideos_mobile_app/controllers/base_screen.controller.dart';
import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:fideos_mobile_app/presentations/cart/cart_flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  // Importing basecontroller
  final controller = Get.put(BaseScreenController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CartFlash(),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColor.white),
                child: Obx(() => BottomNavigationBar(
                    onTap: (index) {
                      controller.onchange(index: index);
                    },
                    currentIndex: controller.selectedIndex.value,
                    backgroundColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    showUnselectedLabels: true,
                    showSelectedLabels: true,
                    unselectedItemColor: Colors.black,
                    selectedItemColor: AppColor.primary,
                    selectedLabelStyle:
                        TextStyle(fontSize: 11, color: AppColor.primary),
                    unselectedLabelStyle:
                        const TextStyle(fontSize: 11, color: Colors.black),
                    selectedIconTheme:
                        IconThemeData(color: AppColor.primary, size: 20),
                    unselectedIconTheme:
                        const IconThemeData(color: Colors.black, size: 20),
                    items: List.generate(
                        4,
                        (index) => items(
                            icon: controller.icons[index],
                            label: controller.screenNames[index])))))),
      ],
    );
  }

// Bottom navbar icon and label
  BottomNavigationBarItem items({required Icon icon, required String label}) =>
      BottomNavigationBarItem(
          icon: Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 2), child: icon),
          label: label);
}
