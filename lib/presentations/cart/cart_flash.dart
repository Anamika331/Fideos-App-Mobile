import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:fideos_mobile_app/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

//  Selected food for cart tile
class CartFlash extends StatelessWidget {
  const CartFlash({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.black.withOpacity(0.09)),
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
            // Food image
            const Expanded(child: Image(image: AssetImage("assets/butter-chicken.png"))),

            // Adding some space
            Space.show(width: 5),

            // Item description
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dominos Pizza",
                      style: TextStyle(color: AppColor.black)),

                      Text("View",
                        style: TextStyle(color: AppColor.black, fontSize: 12))
                ]),

              // Adding some space 
              Space.show(width: 10),
            // Price
            const Expanded(
              child: Text("\$234",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ),
      
            // Adding some space 
            Space.show(width: 10),
            // View cart button 
            Container(
             
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColor.primary),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  children: [
                    Text("View Cart",
                        style: TextStyle(color: AppColor.white, fontSize: 12)),
                        Text('1 Item', style: TextStyle(color: AppColor.white, fontSize: 12))
                  ],
                ),
              ),
            ),

            // Remove button 
            const Expanded(child:  Icon(Feather.x_circle,))
          ]),
        ),
      ),
    );
  }
}
