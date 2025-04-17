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
  // addToCart({food}) async {
  //   // Starting loader
  //   addToCartLoader.value = true;

  //   // final items = itemCounts.entries
  //   //     .where((item) => item.value > 0)
  //   //     .map((item) => {
  //   //           "food": food[item.key],
  //   //           "qty": item.value,
  //   //         })
  //   //     .toList();

  //   // final user  = await  CookieManager('id').get();

  //   // // Creating cart
  //   // final Cart cart = Cart(
  //   //   user: user.toString()
  //   // );

  //   // Convert itemCounts + food map to a List<Items>
  //   final List<Items> items = itemCounts.entries
  //       .where((entry) => entry.value > 0)
  //       .map((entry) => Items(
  //             food: food[entry.key], // get food ID from your map
  //             qty: entry.value,
  //           ))
  //       .toList();

  //   final user = await CookieManager('id').get();

  //   final cart = Cart(user: user.toString(), items: items);

  //   // Fetching response
  //   final response = await cart.addToCart();

  //   // Checking if any error
  //   if (response['error'] != null) {
  //     FlashMessage().show(response['error'].toString());
  //   } else {
  //     // Returning success message
  //     FlashMessage().show('Register Successfully');
  //     Get.to(() => const CartScreen());
  //   }

  //   // Stopping loader
  //   addToCartLoader.value = false;
  // }

  Future<void> addToCart({required List<dynamic> food}) async {
    addToCartLoader.value = true;

    final user = await CookieManager('id').get();

    final items = itemCounts.entries
        .where((item) => item.value > 0)
        .map((item) => Items(
              food: food[item.key]["id"], // replace with correct property
              qty: item.value,
            ))
        .toList();

    log(items.toString());

    final cart = Cart(user: user.toString(), items: items);

    final response = await cart.addToCart();

    if (response['error'] != null) {
      FlashMessage().show(response['error']);
    } else {
      FlashMessage().show('Cart Added!');
      Get.to(() => const CartScreen());

    }

    addToCartLoader.value = false;
  }
}
