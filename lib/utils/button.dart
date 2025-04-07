
import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button {
  String? text;
  Function()? onPressed;

  Button({this.text, this.onPressed});

  show() =>
      ElevatedButton(onPressed: onPressed, child: buttonText(), style: style());

  buttonText() => Text(text ?? "", style: TextStyle(color: AppColor.white));

  style() => ElevatedButton.styleFrom(
      backgroundColor: AppColor.primary,
      fixedSize: Size(Get.width, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ));

  
}
