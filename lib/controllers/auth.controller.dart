import 'dart:developer';

import 'package:fideos_mobile_app/models/user.model.dart';
import 'package:fideos_mobile_app/presentations/auth/login.dart';
import 'package:fideos_mobile_app/presentations/base_screen/dashboard.dart';
import 'package:fideos_mobile_app/utils/cookies.dart';
import 'package:fideos_mobile_app/utils/flash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Login form key
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  // Login email controller
  TextEditingController loginEmailController = TextEditingController();

  // Login password controller
  TextEditingController loginPasswordcontroller = TextEditingController();

  // Login password obsecured
  RxBool passwordObsecured = true.obs;

  // Login button loader
  RxBool loginLoader = false.obs;

  // Register form key
  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  // Register name controller
  TextEditingController regNameContoller = TextEditingController();
  // Register email controller
  TextEditingController regEmailController = TextEditingController();

  // Register password controller
  TextEditingController regPasswordController = TextEditingController();

  // Register confirm password
  TextEditingController regConfirmPasswordController = TextEditingController();

  // Register password obsecured
  RxBool regPasswordObsecured = true.obs;

  // Register confirm password obsecured
  RxBool regConfirmPasswordObsecured = true.obs;

  // Loader for register button
  RxBool regLoader = false.obs;

  // Register
  Future<void> register() async {
    // Starting loader
    regLoader.value = true;

    // Creating new user model
    final User user = User(
        name: regNameContoller.text,
        email: regEmailController.text,
        password: regPasswordController.text);

    // Creating user
    final response = await user.register();

    // Checking if any error
    if (response['error'] != null) {
      FlashMessage().show(response['error'].toString());
    } else {
      // Returning success message
      FlashMessage().show('Register Successfully');
      Get.to(() => const LoginScreen());
    }
    regLoader.value = false;
  }

  // User login
  Future<void> login() async {
    // Starting loader n
    loginLoader.value = true;

    // Preparing user model for login
    final User user = User(
        email: loginEmailController.text,
        password: loginPasswordcontroller.text);

    // Logging in using user login function
    final response = await user.login();

    if (response['error'] != null) {
      FlashMessage().show(response['error'].toString());
    } else if (response['success'] != null) {
      // await CookieManager("id", value: response['success']['id']).save();
      // await CookieManager("user", value: response['success']).save();
      FlashMessage().show('Login Successfully');

      Get.to(() => const DashboardScreen());
    }

    loginLoader.value = false;
  }
}
