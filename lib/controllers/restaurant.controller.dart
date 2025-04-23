import 'dart:developer';

import 'package:fideos_mobile_app/models/menu.model.dart';
import 'package:fideos_mobile_app/models/restaurant.model.dart';
import 'package:fideos_mobile_app/utils/flash.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController {
  List filterMenuList = ["Recommended", "Veg Items", "Non-Veg Items", "Thalis"];

  RxInt menuIndex = 0.obs;

  // List of retaurants
  RxList<Restaurant> restaurants = <Restaurant>[].obs;

  // Retaurant loading button
  RxBool restaurantLoading = false.obs;

  Rx<Restaurant> selectedRestaurant = Restaurant().obs;
  RxString restaurantId = "".obs;

  // Fetching all restaurants
  allRestaurants() async {
    // Starting loader
    restaurantLoading.value = true;

    // Creating new restaurant onject
    final restaurant = Restaurant();

    // Fetching allRestaurat function from model
    final response = await restaurant.allRestaurant();

    // Checking if error is null or not
    if (response['error'] != null) {
      FlashMessage().show(response['error'].toString());
    } else if (response['success'] != null) {
      // If response is success -- asigning to restaurant list
      restaurants.assignAll(response['success']);

      // Refreshing the list
      restaurants.refresh();

      // Showing flash message
      FlashMessage().show('Restaurants fetched successfully');
    }
    restaurantLoading.value = false;
  }

  // Loader for restaurant detail
  RxBool restaurantDetailLoading = false.obs;
  // Fetching all restaurants
  restaurantDetail() async {
    // Starting loader
    restaurantDetailLoading.value = true;

    // Creating new restaurant onject
    final restaurant = Restaurant();

    // Fetching restaurant function from model
    final response =
        await restaurant.restaurantDetails(restaurantId.toString());

    if (response['error'] != null) {
      FlashMessage().show(response['error'].toString());
    } else if (response['success'] != null) {
      // restaurants.assignAll(response['success']);
      selectedRestaurant.value = Restaurant.fromJson(response['success']);

      await restaurantMenu(selectedRestaurant.value.id.toString());
      // restaurants.refresh();
      FlashMessage().show('Restaurants fetched successfully');
    }
    restaurantDetailLoading.value = false;
  }

  // Loader for restaurant menu
  RxBool menuLoader = false.obs;

  // Restaurant menu list
  RxList<RestaurantMenu> menuItems = <RestaurantMenu>[].obs;

  restaurantMenu(id) async {
    // Starting loader for menu
    menuLoader.value = true;

    // Creating new menu
    final menu = RestaurantMenu();

    // fetching response
    final response = await menu.restaurantMenu(id);

    // Checking if response has error or not
    if (response['error'] != null) {
      FlashMessage().show(response['error'].toString());
    } else if (response['success'] != null) {
      menuItems.assignAll(response['success']);

      menuItems.refresh();
      log('Menu fetched successfully');
    }

    // Stopping loader for menu
    menuLoader.value = false;
  }
}
