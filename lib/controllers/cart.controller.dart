import 'dart:developer';
import 'dart:io';

import 'package:fideos_mobile_app/models/cart.model.dart';
import 'package:fideos_mobile_app/presentations/cart/cart_screen.dart';
import 'package:fideos_mobile_app/utils/cookies.dart';
import 'package:fideos_mobile_app/utils/flash.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  RxBool cartLoading = false.obs;

  // item count to get each index
  RxMap<int, int> itemCounts = <int, int>{}.obs;

  void incrementCount(int id) {
    cartLoading.value = true;
    itemCounts[id] = (itemCounts[id] ?? 0) + 1;
    cartLoading.value = false;
  }

  void decrementCount(int id) {
    if ((itemCounts[id] ?? 0) > 0) {
      itemCounts[id] = itemCounts[id]! - 1;
    }
  }

  int getCount(int id) => itemCounts[id] ?? 0;

  int get totalItemsAdded =>
      itemCounts.values.fold(0, (sum, count) => sum + count);

  // Loader for add to cart
  RxBool addToCartLoader = false.obs;

  // Add item to cart
  Future<void> addToCart({required List<dynamic> food, required String restaurant}) async {
    addToCartLoader.value = true;

    final user = await CookieManager('id').get();

    log(user.toString());
    final items = itemCounts.entries
      .where((item) => item.value > 0)
      .map((item) => Items(
            food: Food(id: food[item.key]),
            qty: item.value,
          ))
      .toList();


    final cart = Cart(user: user.toString(), items: items);

    final response = await cart.addToCart(restaurant: restaurant);

    log(response.toString());

    if (response['error'] != null) {
      FlashMessage().show(response['error']);
    } else {
      FlashMessage().show('Cart Added!');
      Get.to(() => const CartScreen());
    }

    addToCartLoader.value = false;
  }

  // Cart Loader 
  RxBool cartLoader = false.obs;
  
  RxList<Cart> carts = <Cart>[].obs;

  // Fetch all cart items
  allCartItems() async{
    // Starting cart loader
    cartLoader.value = true;

    // Getting user id from cookie
    final userId = await CookieManager('id').get();

    // Creating Cart 
    final cart = Cart();

    // Fetching response 
    final response  = await cart.allCartItems(userId: userId.toString());

    log(response.toString());

    // Cecking if response has error or not 
    if(response["error"] != null) {
      FlashMessage().show(response['error']);
    }else if (response['success'] != null) {
      // If response is success -- asigning to cart list
      carts.assignAll(response['success']);

      // Refreshing the list
      carts.refresh();

      // Showing flash message
      FlashMessage().show('Restaurants fetched successfully');
    }

    // Stopping loader 
    cartLoader.value =  false;
  }



}
