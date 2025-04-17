import 'package:dio/dio.dart';
import 'package:fideos_mobile_app/services/api.services.dart';

class RestaurantMenu {
  int? foodCount;
  String? title;

  RestaurantMenu({this.foodCount, this.title});

  RestaurantMenu.fromJson(Map<String, dynamic> json) {
    foodCount = json['foodCount'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['foodCount'] = foodCount;
    data['title'] = title;
    return data;
  }

  // Restaurant menu
 Future<Map<String, dynamic>> restaurantMenu(id) async {
    try {
      // Preparing endpoint
      final endpoint = "/restaurants/$id/menu";

      // Fetching response
      final response = await APIClient(endpoint).get();

      // Extrating data from response
      final data = response?.data;

      // Checking if data is null or not
      if (data != null && data['data'] is List) {
        final List<dynamic> restaurantMenu = data['data'];
        return {
          'success': restaurantMenu.map((menu) => RestaurantMenu.fromJson(menu)).toList()
        };
      }
      else {
        return {'error': 'Invalid response format'};
      }
    } on DioException catch (e) {
      return {'error': e.response?.data['error'] ?? 'Something went wrong'};
    } catch (e) {
      return {'error': 'Unexpected error: $e'};
    }
  }
}
