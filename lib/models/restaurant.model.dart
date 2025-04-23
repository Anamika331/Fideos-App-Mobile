import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fideos_mobile_app/services/api.services.dart';

class Restaurant {
  Location? location;
  bool? enabled;
  String? name;
  String? description;
  double? rating;
  String? openingTime;
  String? closingTime;
  String? image;
  List<Videos>? videos;
  List<Food>? food;
  String? createdAt;
  String? updatedAt;
  String? id;

  Restaurant(
      {this.location,
      this.enabled,
      this.name,
      this.description,
      this.rating,
      this.openingTime,
      this.closingTime,
      this.image,
      this.videos,
      this.food,
      this.createdAt,
      this.updatedAt,
      this.id});

  Restaurant.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    enabled = json['enabled'];
    name = json['name'];
    description = json['description'];
    rating = json['rating'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    image = json['image'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
    if (json['food'] != null) {
      food = <Food>[];
      json['food'].forEach((v) {
        food!.add(Food.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['enabled'] = enabled;
    data['name'] = name;
    data['description'] = description;
    data['rating'] = rating;
    data['openingTime'] = openingTime;
    data['closingTime'] = closingTime;
    data['image'] = image;
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    if (food != null) {
      data['food'] = food!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }

  // Find all restaurant
  Future<Map<String, dynamic>> allRestaurant() async {
    try {
      const endpoint = "/restaurants";
      final response = await APIClient(endpoint).get();

      final data = response?.data;

      // Safely get the list of restaurants from the 'success' key
      if (data != null && data['data'] is List) {
        final List<dynamic> restaurantList = data['data'];

        return {
          "success": restaurantList
              .map((restaurant) => Restaurant.fromJson(restaurant))
              .toList()
        };
      } else {
        return {'error': 'Invalid response format'};
      }
    } on DioException catch (e) {
      return {'error': e.response?.data['error'] ?? 'Something went wrong'};
    } catch (e) {
      return {'error': 'Unexpected error: $e'};
    }
  }

  // Restaurant detail
  Future<Map<String, dynamic>> restaurantDetails(String restaurantId) async {
    try {
      final endpoint = "/restaurants/$restaurantId";

      log(endpoint.toString());
      final response = await APIClient(endpoint).get();

      final data = response?.data;

      // Safely get the list of restaurants from the 'success' key
      if (data != null ) {
        final resturant = data['data'];

        return {"success": resturant};
      } else {
        return {'error': 'Invalid response format'};
      }
    } on DioException catch (e) {
      return {'error': e.response?.data['error'] ?? 'Something went wrong'};
    } catch (e) {
      return {'error': 'Unexpected error: $e'};
    }
  }

 
}

// Location

class Location {
  String? fullAddress;
  String? city;
  String? state;
  int? pin;
  double? latitude;
  double? longitude;

  Location(
      {this.fullAddress,
      this.city,
      this.state,
      this.pin,
      this.latitude,
      this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    fullAddress = json['fullAddress'];
    city = json['city'];
    state = json['state'];
    pin = json['pin'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fullAddress'] = fullAddress;
    data['city'] = city;
    data['state'] = state;
    data['pin'] = pin;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

// Video
class Videos {
  String? url;
  String? title;
  String? description;
  String? food;
  String? createdAt;
  String? updatedAt;
  String? id;

  Videos(
      {this.url,
      this.title,
      this.description,
      this.food,
      this.createdAt,
      this.updatedAt,
      this.id});

  Videos.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    title = json['title'];
    description = json['description'];
    food = json['food'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['url'] = url;
    data['title'] = title;
    data['description'] = description;
    data['food'] = food;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}


// Food 
class Food {
  String? name;
  String? description;
  FoodCategory? foodCategory;
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
    foodCategory = json['foodCategory'] != null
        ? FoodCategory.fromJson(json['foodCategory'])
        : null;
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
    if (foodCategory != null) {
      data['foodCategory'] = foodCategory!.toJson();
    }
    data['images'] = images;
    data['price'] = price;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }
}


// Food Category
class FoodCategory {
  String? title;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  FoodCategory(
      {this.title,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt});

  FoodCategory.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  
}


