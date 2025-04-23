import 'dart:developer';

import 'package:fideos_mobile_app/controllers/base_screen.controller.dart';
import 'package:fideos_mobile_app/controllers/restaurant.controller.dart';
import 'package:fideos_mobile_app/models/color.model.dart';
import 'package:fideos_mobile_app/models/restaurant.model.dart';
import 'package:fideos_mobile_app/presentations/cart/cart_flash.dart';
import 'package:fideos_mobile_app/presentations/restaurant/restaurant.detail.dart';
import 'package:fideos_mobile_app/utils/loader.dart';
import 'package:fideos_mobile_app/utils/seperator.dart';
import 'package:fideos_mobile_app/utils/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Import controller
  final _baseScreenController = Get.put(BaseScreenController());

  final _restaurantController = Get.put(RestaurantController());

  @override
  void initState() {
    super.initState();

    _restaurantController.restaurants.refresh();
    _restaurantController.allRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //  Top Image
      TopImage(),

      // Adding some space
      Space.show(height: 20),

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          // Search box
          searchBox,

          // Adding some space
          Space.show(height: 15),

          // Seperator
          Seperator(text: 'All Restaurants Near You', horizontalPadding: 0)
              .show(),

          // Adding some space
          Space.show(height: 15),

          // Filter option
          SizedBox(
            height: 30,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(_restaurantController.menuItems[index].title.toString()),
                  );
                },
                separatorBuilder: (context, index) {
                  return Space.show(width: 5);
                },
                itemCount: _restaurantController.menuItems.length),
          ),

          // Adding some space
          Space.show(height: 10),

          // Title
          Text("197 restaurants delivering to you",
              style: TextStyle(color: AppColor.black.withOpacity(0.3))),

          // Adding some space
          Space.show(height: 10),

          // Restaurant tile
          Obx(() => _restaurantController.restaurantLoading.value
              ? Loader().show()
              : Column(
                  children: [
                    ...List.generate(
                        _restaurantController.restaurants.length,
                        (index) => InkWell(
                            onTap: () {
                              _restaurantController.restaurantId.value = _restaurantController.restaurants[index].id.toString();

                              log(_restaurantController.restaurantId.toString());

                              Get.to(() => RestaurantDetail());
                              
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: RestaurantTile(
                                restaurant:
                                    _restaurantController.restaurants[index],
                              ),
                            ))),
                  ],
                )),

          // ...List.generate(_restaurantController.restaurants.length,
          // (index) => Text('jjhdjh')),

          // Adding some space
          Space.show(height: 10),
        ]),
      )
    ]);
  }

  // Search field
  Widget get searchBox => Container(
      padding: const EdgeInsets.all(5),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black12)),
      child: Row(children: [
        // Search icon
        const Icon(Feather.search),
        // Adding some space
        Space.show(width: 5),

        // Search text
        const Text('Search for a Restaurant or Dish',
            style: TextStyle(color: Colors.black38)),

        // Aadding some space
        Space.show(width: 20),

        // vertical divider
        SizedBox(
            height: 40,
            child: VerticalDivider(
              color: AppColor.primary,
              thickness: 2,
            )),

        // Mic icon
        const Icon(
          Feather.mic,
          color: Colors.black54,
        ),
      ]));
}

// Top Image section
class TopImage extends StatelessWidget {
  TopImage({super.key});

  final _baseScreenController = Get.put(BaseScreenController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: Get.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          image: DecorationImage(
              image: AssetImage('assets/home_screen_bg.png'),
              fit: BoxFit.cover)),
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address
            Text("Salt Lake",
                style: TextStyle(
                    color: AppColor.white, fontWeight: FontWeight.w600)),
            Text("EN Block, Ergo Tower, Sector 5",
                style: TextStyle(color: AppColor.white)),

            //  Adding some space
            Space.show(height: 25),

            // Trending videos
            trendingFoodVideos,

            // Adding some space
            Space.show(height: 10),

            // Selected restaurants
            selectedRestaurants
          ],
        ),
      ),
    );
  }

  // Trending food video section
  Widget get trendingFoodVideos => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trending video title
          Text("Trending Food Videos from Restaurants",
              style: TextStyle(color: AppColor.white)),
          // Trending Video
          SizedBox(
              height: 80,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          _baseScreenController.trendiingVideos[index]),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Space.show(width: 10);
                  },
                  itemCount: _baseScreenController.trendiingVideos.length))
        ],
      );

  // Selected restaurants
  Widget get selectedRestaurants =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Title
        Text('Restaurants Selected Only For You',
            style: TextStyle(color: AppColor.white)),

        // Selected restaurats list
        SizedBox(
            height: 140,
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 60, crossAxisCount: 2),
              itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    // Selected restaurant image
                    const Image(image: AssetImage('assets/butter-chicken.png')),

                    // Adding some space
                    Space.show(width: 5),

                    // Restaurants details
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          //  Restaurant name
                          Expanded(
                              child: Text('Aalia Biryani',
                                  style: TextStyle(
                                      fontSize: 13,
                                      height: 1,
                                      color: AppColor.white))),

                          //  Restaurant description
                          Expanded(
                              child: Text('24 mins away from you',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 11,
                                      height: 1,
                                      color: AppColor.white))),

                          //  Restaurant address
                          Text('Biryani, Moghlai and more',
                              maxLines: 1,
                              style: TextStyle(
                                  height: 1,
                                  color: AppColor.white,
                                  fontSize: 11))
                        ]))
                  ])),
            ))
      ]);
}

// Restaurant Tile
class RestaurantTile extends StatelessWidget {
  RestaurantTile({super.key, required this.restaurant});

  Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColor.black.withOpacity(0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          Container(
            height: 150,
            width: Get.width,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                image: DecorationImage(
                    image: NetworkImage(restaurant.image.toString()),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(Feather.heart,
                      color: AppColor.white.withOpacity(0.7))),
            ),
          ),

          // Restaurant detail
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(restaurant.name.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                    Text('Pizza, Burger, Pasta and more',
                        style: TextStyle(
                            color: AppColor.black.withOpacity(0.3),
                            fontSize: 12)),
                    Text('25 mins from your location',
                        style: TextStyle(
                            color: AppColor.black.withOpacity(0.3),
                            fontSize: 12)),
                    Text(
                        '${restaurant.location!.fullAddress} ${restaurant.location!.city}',
                        style: TextStyle(
                            color: AppColor.black.withOpacity(0.3),
                            fontSize: 12)),
                  ],
                ),

                // Rating Button
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: AppColor.green,
                      borderRadius: BorderRadius.circular(5)),
                  child:  Row(
                    children: [
                      // Star icon
                      const Icon(Icons.star, color: Colors.white, size: 20),
                      // Rating
                      Text(
                        restaurant.rating.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
