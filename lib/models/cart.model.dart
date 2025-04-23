import 'package:dio/dio.dart';
import 'package:fideos_mobile_app/services/api.services.dart';

class Cart {
  String? user;
  List<Items>? items;
  String? createdAt;
  String? updatedAt;
  String? id;

  Cart({this.user, this.items, this.createdAt, this.updatedAt, this.id});

  Cart.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user'] = user;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }

  // // Adding item  to cart
  addToCart({ required String restaurant}) async {
    try {
      // Preparing endpoint
    const endpoint = "/carts/save";

    // Preparing request body
    final body = {
      "user": user,
      "restaurant": restaurant,
      "items": items!.map((item) => item.toJson()).toList(),
    };

    // Fethcing response
    final response = await APIClient(endpoint).post(body);

    // returning response
    return{"success": response!.data};
    } on DioException catch (e) {
      return {"error": e.response!.data["error"]};
    }
  }

  // Fetch all cart items 
  Future<Map<String, dynamic>> allCartItems({required String userId}) async{
    try {
      // Preparting endoint
      final endpoint  = "/carts/user/$userId";

      // Fetching response 
      final response = await APIClient(endpoint).get();
        final data = response?.data;


      // Safely get the list of restaurants from the 'success' key
      if (data != null && data['data'] is List) {
        final List<dynamic> carts = data['data'];

        return {
          "success": carts
              .map((cart) => Cart.fromJson(cart))
              .toList()
        };
      } else {
        return {'error': 'Invalid response format'};
      }
     
    } on DioException catch (e) {
      return {"erorr": e.response!.data["error"]};
    }
  }
  
}

class Items {
  Food? food;
  int? qty;
  String? sId;
  String? id;

  Items({this.food, this.qty, this.sId, this.id});

  Items.fromJson(Map<String, dynamic> json) {
    food = json['food'] != null ? Food.fromJson(json['food']) : null;
    qty = json['qty'];
    sId = json['_id'];
    id = json['id'];
  }

 Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = {};
  if (food != null) {
    data['food'] = food!.id; // Only the ID
  }
  data['qty'] = qty;
  data['_id'] = sId;
  data['id'] = id;
  return data;
}
}

class Food {
  String? name;
  String? description;
  String? foodCategory;
  List<String>? images;
  double? price;
  String? createdAt;
  String? updatedAt;
  String? id;

  Food(
      {this.name,
      this.description,
      this.foodCategory,
      this.images,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.id});

  Food.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    foodCategory = json['foodCategory'];
    images = json['images'].cast<String>();
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['description'] = description;
    data['foodCategory'] = foodCategory;
    data['images'] = images;
    data['price'] = price;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}
