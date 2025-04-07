import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlashMessage {
  show(String message) => ScaffoldMessenger.of(Get.context!)
      .showSnackBar(SnackBar(content: Text(message)));
}
