import 'package:fideos_mobile_app/models/restaurant.model.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController {
  RxBool cartLoading = false.obs;
  RxInt count = 0.obs;

  void incrementCount(id) {
    cartLoading.value = true;
    count.value++;
    cartLoading.value = false;
  }

  void decrementCount(id) {
    if (count.value <= 0) {
    } else {
      count.value--;
    }
  }

  List filterMenuList = ["Recommended", "Veg Items", "Non-Veg Items", "Thalis"];

  RxInt menuIndex = 0.obs;

  // List of retaurants
  RxList<Restaurant> restaurants = <Restaurant>[].obs;

  // Retaurant loading button
  RxBool restaurantLoading = false.obs;

  // Fetching all restaurants
  Future<void> allRestaurants() async {
    // Starting loader
    restaurantLoading.value = true;

    
  }
}
