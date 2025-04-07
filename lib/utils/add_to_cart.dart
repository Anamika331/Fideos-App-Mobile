
import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:flutter/material.dart';


class Addtocartbutton extends StatelessWidget {
  const Addtocartbutton({super.key, required this.onpressed});

  final Function onpressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: OutlinedButton(
          style: addtocartbuttonstyle,
          onPressed: () {
            onpressed();
          },
          child: Text("Add to Cart",
              style: TextStyle(fontSize: 12,  color: AppColor.white)))
    );
  }

  /* add to cart button style */
  ButtonStyle get addtocartbuttonstyle => OutlinedButton.styleFrom(
      fixedSize: const Size(130, 30),
      backgroundColor: AppColor.primary,
      side: BorderSide(color: AppColor.primary.withOpacity(0.5), width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)));
}
