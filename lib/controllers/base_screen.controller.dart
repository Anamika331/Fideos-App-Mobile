import 'package:fideos_mobile_app/presentations/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class BaseScreenController extends GetxController {
  // List of trending videos
  List trendiingVideos = [
    'assets/butter-chicken.png',
    'assets/kadai-paneer.png',
    'assets/pizza-with-olives.png',
    'assets/butter-chicken.png',
    'assets/kadai-paneer.png',
  ];

  // Selected index for bottom nav item
  RxInt selectedIndex = 0.obs;

  // Bottom navigation icons
  List icons = [
    const Icon(Icons.delivery_dining_outlined),
    const Icon(Feather.video),
    const Icon(Feather.shopping_cart),
    const Icon(Feather.box),
    // const Icon(Feather.user),
  ];

  void onchange({required int index}) => selectedIndex.value = index;

  // Screen Names
  List screenNames = ['Home', 'Video', 'Cart', 'Order'];

  // Screens
  List screens = const [HomeScreen(), Text('Trending video'), Text('Cart'), Text('Order')];

  // Filter options 
  List filterOption =  ['Sort', 'Nearest', 'Rating 4.0+', 'Pure veg', 'Items'];
}
