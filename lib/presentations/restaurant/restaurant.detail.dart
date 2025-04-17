import 'dart:developer';

import 'package:fideos_mobile_app/controllers/cart.controller.dart';
import 'package:fideos_mobile_app/controllers/restaurant.controller.dart';
import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:fideos_mobile_app/models/menu.model.dart';
import 'package:fideos_mobile_app/models/restaurant.model.dart';
import 'package:fideos_mobile_app/utils/add_to_cart.dart';
import 'package:fideos_mobile_app/utils/appbar.dart';
import 'package:fideos_mobile_app/utils/loader.dart';
import 'package:fideos_mobile_app/utils/seperator.dart';
import 'package:fideos_mobile_app/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class RestaurantDetail extends StatefulWidget {
  RestaurantDetail({super.key});

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  // Importing restaurant controller
  final _restaurantController = Get.put(RestaurantController());

  // Importing cart controller
  final _cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    _restaurantController.restaurantDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _bottomAppBar,
        floatingActionButton: _floatingActionButton,
        appBar:
            PreferredSize(preferredSize: Size(Get.width, 50), child: appbar),
        body: Obx(() {
          if (_restaurantController.restaurantDetailLoading.value) {
            return Center(child: Loader().show());
          } else {
            return SingleChildScrollView(
              child: Column(children: [
                Text(_restaurantController.selectedRestaurant.value.id
                    .toString()),
                // Restaurant name
                Text(
                  _restaurantController.selectedRestaurant.value.name
                      .toString(),
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                ),

                // Description
                const Text(
                  'Pizza, Burger, Pasta and more',
                  style: TextStyle(color: Colors.black38, fontSize: 12),
                ),

                //  Adding some space
                Space.show(height: 10),

                // Rating
                rating,

                // Adding some space
                Space.show(height: 10),

                // Address
                Text(_restaurantController
                    .selectedRestaurant.value.location!.fullAddress
                    .toString()),

                // Adding some space
                Space.show(height: 10),

                // Duration
                Container(
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

                // Adding some space
                Space.show(height: 20),

                // Seperator
                Seperator(text: 'All Food Items Available').show(),

                // Adding some space
                Space.show(height: 10),

                // Food tile
                FoodTile(
                    items:
                        _restaurantController.selectedRestaurant.value.food!),

                // // Adding some space
                // Space.show(height: 10),

                // // Only veg items
                // FoodTile(
                //   title: 'Only Veg Items',
                //   id: 'veg',
                // ),
              ]),
            );
          }
        }));
  }

  // Appbar
  Widget get appbar => CommonAppBar(
      title: Space.show(),
      leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Feather.arrow_left)),
      actions: const Row(children: [
        Icon(Feather.heart),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Icon(Feather.share_2)),
        Icon(Feather.more_vertical)
      ]));

  // Rating row
  Widget get rating => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColor.green, borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                // Star icon
                const Icon(Icons.star, color: Colors.white, size: 20),
                // Rating
                Text(
                    '${_restaurantController.selectedRestaurant.value.rating} +',
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
          // Adding some space
          Space.show(width: 10),
          const Text('3.8k Ratings')
        ],
      );

  // Botton nav
  Widget get _bottomAppBar => Obx(() => _cartController.addToCartLoader.value
      ? Loader().show()
      : BottomAppBar(
          elevation: 0,
          height: 50,
          padding: EdgeInsets.zero,
          child: InkWell(
            onTap: () {
              final foodIds = _restaurantController.selectedRestaurant.value.food!.map((food) => food.id).toList();
              _cartController.addToCart(food: foodIds);
            },
            child: Container(
              height: 55,
              color: AppColor.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Text(
                        '${_cartController.totalItemsAdded} Item added',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColor.white),
                      )),
                   Icon(
                    Icons.arrow_forward_sharp,
                    color: AppColor.white,
                  )
                ],
              ),
            ),
          ),
        ));

  //  Floatng action button
  Widget get _floatingActionButton => Container(
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColor.black),
        height: 40,
        width: 90,
        child: FloatingActionButton(
            backgroundColor: AppColor.black,
            onPressed: () {
              // log(_restaurantController.selectedRestaurant.value.id.toString());
              _restaurantController.restaurantMenu(
                  _restaurantController.selectedRestaurant.value.id.toString());
              _menuDialog();
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.restaurant_menu, color: AppColor.white),
              Text("Menu", style: TextStyle(color: AppColor.white)),
            ])),
      );

  // Menu dialog
  _menuDialog() =>
      Get.dialog(Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        //  Close icon
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.close, color: AppColor.white)),
        //  Adding some space
        const SizedBox(height: 10),
        // Menu Dialog
        AlertDialog(
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          content: SizedBox(
              width: Get.width,
              child: Obx(() => _restaurantController.menuLoader.value
                  ? Space.show()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          const Text("Menu", style: TextStyle(fontSize: 16)),
                          ...List.generate(
                              _restaurantController.menuItems.length,
                              (index) => Obx(() => SizedBox(
                                    height: 40,
                                    child: InkWell(
                                      onTap: () {
                                        _restaurantController.menuIndex.value =
                                            index;
                                      },
                                      child: ListTile(
                                        selectedColor: AppColor.primary,
                                        contentPadding: EdgeInsets.zero,
                                        leading: Text(
                                            _restaurantController
                                                .menuItems[index].title
                                                .toString(),
                                            style: TextStyle(
                                                color: index ==
                                                        _restaurantController
                                                            .menuIndex.value
                                                    ? AppColor.primary
                                                    : AppColor.black)),
                                        leadingAndTrailingTextStyle: TextStyle(
                                            fontFamily: "Lexend-Regular",
                                            // fontSize: 16,
                                            color: AppColor.black),
                                        trailing: Text(
                                            _restaurantController
                                                .menuItems[index].foodCount
                                                .toString(),
                                            style: TextStyle(
                                                color: index ==
                                                        _restaurantController
                                                            .menuIndex.value
                                                    ? AppColor.primary
                                                    : AppColor.black)),
                                      ),
                                    ),
                                  )))
                        ]))),
        ),
      ]));
}

// Food Tile
class FoodTile extends StatefulWidget {
  FoodTile({super.key, required this.items});
  List<Food> items;

  @override
  State<FoodTile> createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> {
  // final _restaurantController = Get.put(RestaurantController());
  final _cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text("Recommended items only for you",
              textAlign: TextAlign.start, style: TextStyle(fontSize: 16)),

          // Adding some space
          Space.show(height: 10),

          // List of food
          ...List.generate(
              widget.items.length,
              (index) => Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Food image
                            Container(
                              height: 180,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: NetworkImage(widget
                                          .items[index].images![0]
                                          .toString()),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text('20% OFF',
                                        style:
                                            TextStyle(color: AppColor.white))),
                              ),
                            ),

                            // Adding some space
                            Space.show(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Most Favorite Item',
                                      style:
                                          TextStyle(color: AppColor.primary)),

                                  Text(widget.items[index].name.toString()),

                                  Text(
                                      widget.items[index].description
                                          .toString(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis)),

                                  // Adding some space
                                  Space.show(height: 10),

                                  // Price row
                                  Row(children: [
                                    Text('\$${widget.items[index].price}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    Space.show(width: 10),
                                    const Text('\$230',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500))
                                  ]),

                                  // Adding some space
                                  Space.show(height: 10),

                                  addToCartButton(id: index)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(color: AppColor.black.withOpacity(0.03))
                      ],
                    ),
                  ))
        ],
      ),
    );
  }

  // add to cart button
  Widget addToCartButton({required int id}) => Obx(() {
        int count = _cartController.getCount(id);

        return count == 0
            ? Addtocartbutton(onpressed: () {
                _cartController.incrementCount(id);
              })
            : OutlinedButton(
                style: OutlinedButton.styleFrom(
                    fixedSize: const Size(130, 30),
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
                            size: 17, color: Colors.black)),
                    Text(count.toString(),
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14)),
                    InkWell(
                        onTap: () {
                          _cartController.incrementCount(id);
                        },
                        child: const Icon(Icons.add,
                            size: 17, color: Colors.black))
                  ],
                ),
              );
      });
}
