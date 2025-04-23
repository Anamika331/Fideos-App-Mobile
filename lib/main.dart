import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:fideos_mobile_app/presentations/auth/login.dart';
import 'package:fideos_mobile_app/presentations/base_screen/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: "Lexend",
            primaryColor: AppColor.primary),
        home: const DashboardScreen());
  }
}
