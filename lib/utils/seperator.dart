import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:flutter/material.dart';

class Seperator {
  final double horizontalPadding;
  final double verticalPadding;
  final String text;
  Seperator(
      {this.horizontalPadding = 15,
      this.verticalPadding = 0,
      required this.text});

  show() => Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Expande left side divider
            const Expanded(child: Divider(color: Colors.black12)),

            // Text between two divider
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Text(text,
                    style: TextStyle(color: AppColor.grey, fontFamily: "Lexend", fontSize: 12))),

            // Expande right side divider
            const Expanded(child: Divider(color: Colors.black12))
          ]));
}
