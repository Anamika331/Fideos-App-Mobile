import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonOutlineButton extends StatelessWidget {
  const CommonOutlineButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return  Container(
    width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColor.primary, width: 2)
      ),
      child:
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(child: Text(text, style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.w600))),
          ),
);

  }
}