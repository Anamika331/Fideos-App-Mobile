import 'package:fideos_mobile_app/controllers/base_screen.controller.dart';
import 'package:fideos_mobile_app/presentations/base_screen/bottom_navbar.dart';
import 'package:fideos_mobile_app/presentations/cart/cart_flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Importing controller
  final _baseScreenController = Get.put(BaseScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomNavbar(),
        body: SingleChildScrollView(
            child: Center(
                child: Obx(() => _baseScreenController
                    .screens[_baseScreenController.selectedIndex.value]))));
  }
}
