import 'package:fideos_mobile_app/controllers/cart.controller.dart';
import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:fideos_mobile_app/utils/appbar.dart';
import 'package:fideos_mobile_app/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bottomAppbar,
        appBar:
            PreferredSize(preferredSize: Size(Get.width, 50), child: appBar),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space.show(height: 10),
                // Duration
                Center(
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Feather.clock, size: 20),
                        Space.show(width: 5),
                        const Text('20-25 mins from your location')
                      ],
                    ),
                  ),
                ),
            
                // Adding some space
                Space.show(height: 15),
            
                // Horizontal divider
                Divider(color: AppColor.black.withOpacity(0.1)),
            
                CartItemTile(),
            
                // Bill summary
                billSummary, 

                //Divider
                Divider(color: AppColor.black.withOpacity(0.09)),

                // Adding some space 
                Space.show(height: 10),

                // Cancellation policy title
                const Text('Cancellation Policy', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),

                // Adding some space 
                Space.show(height: 5),

                // Cancellation policy 
                Text('You can cancel your order within 60 seconds of placing order, your canceled order will go to the people who can not afford food by their own.',
                  style: TextStyle(color: AppColor.black.withOpacity(0.2), fontSize: 13)
                ),

                // Adding some space
                Space.show(height: 10),
                //Divider
                Divider(color: AppColor.black.withOpacity(0.09)),

                Space.show(height: 50),

                Text('Due to some internal issue, we are only accepting Cash On Delivery Orders.', style: TextStyle(color: AppColor.primary, fontSize: 12),)

              ],
            ),
          ),
        ));
  }

  // Bill Summary

  Widget get billSummary => const Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bill summary
            Text('Restaurant Bill Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        
        
            // Total Item price 
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image(image: AssetImage('assets/bag.png'), height: 25,),
              title: Text('Item Total'),
              trailing: Text('\$500', style: TextStyle(fontSize: 16)),
            ),
        
            // Tax value 
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image(image: AssetImage('assets/castel.png'), height: 25,),
              title: Text('GST and other taxes'),
              trailing: Text('\$10', style: TextStyle(fontSize: 16)),
            ),
        
            // Delivery partner fee
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image(image: AssetImage('assets/dinning.png'), height: 25,),
              title: Text('Delivery Partner Fees'),
              trailing: Text('\$120', style: TextStyle(fontSize: 16)),
            ),
            
        
            // Grand total value
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image(image: AssetImage('assets/bell.png'), height: 25,),
              title: Text('Grand Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
              trailing: Text('\$300', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            )
          ],
        ),
);



  // Appbar
  Widget get appBar => CommonAppBar(
        leading: const Icon(Feather.arrow_left),
        title: const Text("Your Cart from Domino's Pizza",
            style: TextStyle(fontSize: 20)),
        actions: Space.show(),
      );

  // Bottom app bar
  Widget get bottomAppbar => BottomAppBar(
        height: 50,
        color: AppColor.primary,
        child: Center(
            child: Text(
          'Select Address and Pay',
          style: TextStyle(color: AppColor.white),
        )),
      );
}

// Cart Item Tile
class CartItemTile extends StatelessWidget {
  CartItemTile({super.key});
  final _cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
            3,
            (index) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Food Image
                          const Image(
                              image: AssetImage('assets/kadai-paneer.png'),
                              height: 90,
                              width: 80),
    
                          // Adding some space
                          Space.show(width: 5),
    
                          // Food details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Food name
                                const Text('Kadai Panner',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600)),
    
                                // Food Description
                                const Text(
                                    'Kadai Paneer is a spicy, warming, flavorful and super delicious dish',
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black12,
                                        overflow: TextOverflow.ellipsis)),
    
                                Space.show(height: 5),
    
                                // Price and offer price
                                Row(
                                  children: [
                                    const Text(
                                      '\$230',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Space.show(width: 5),
                                    const Text(
                                      '\$230',
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
    
                          // Adding some space
                          Space.show(width: 10),
    
                          addToCartButton(),
                        ],
                      ),
                    ),
                    Divider(
                      color: AppColor.black.withOpacity(0.09),
                    )
                  ],
                )),
      ],
    );
  }

  // add to cart button
  Widget addToCartButton({String? id}) => Column(
        children: [
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  fixedSize: const Size(100, 30),
                  side: BorderSide(
                      color: AppColor.primary.withOpacity(0.5), width: 1.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              onPressed: () {},
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          _cartController.decrementCount(id);
                        },
                        child: const Icon(Icons.remove,
                            size: 17, color: Colors.white)),
                    Obx(() => Text(_cartController.count.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14))),
                    InkWell(
                        onTap: () {
                          _cartController.incrementCount(id);
                        },
                        child: const Icon(Icons.add,
                            size: 17, color: Colors.white))
                  ])),
          Text(
            '\$500',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      );
}

//
