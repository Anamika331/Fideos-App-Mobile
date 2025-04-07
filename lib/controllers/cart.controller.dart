import 'package:get/get.dart';

class CartController extends GetxController{
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
}