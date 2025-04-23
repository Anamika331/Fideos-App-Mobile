import 'package:dio/dio.dart';
import 'package:fideos_mobile_app/services/api.services.dart';

class User {
  bool? enabled;
  String? name;
  String? email;
  String? password;
  dynamic phone;
  dynamic gender;
  Address? address;
  String? createdAt;
  String? updatedAt;
  String? id;

  User(
      {this.enabled,
      this.name,
      this.email,
      this.password,
      this.phone,
      this.gender,
      this.address,
      this.createdAt,
      this.updatedAt,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    gender = json['gender'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['enabled'] = enabled;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['gender'] = gender;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['id'] = id;
    return data;
  }

  // User create/register
  register() async {
    try {
      // Preparing body object
      final body = {'name': name, 'email': email, 'password': password};

      // Preparing endpoint
      const endpoint = "/users/save";

      // Fetching response from api
      final response = await APIClient(endpoint).post(body);

      // Returning response
      return {'success': response!.data};
    } on DioException catch (e) {
      return {'error': e.response!.data['error']};
    }
  }

  // User login
  login() async {
    try {
      // Preparing request body
      final body = {'email': email, 'password': password};

      // Preparing endpoint
      const endpoint = "/users/login";

      // Fetching response
      final response = await APIClient(endpoint).post(body);

      return {'success': response!.data["data"]};
    } on DioException catch (e) {
      return {'error': e.response!.data['error']};
    }
  }
}

class Address {
  dynamic fullAddress;
  dynamic sate;
  dynamic city;
  dynamic pin;

  Address({this.fullAddress, this.sate, this.city, this.pin});

  Address.fromJson(Map<String, dynamic> json) {
    fullAddress = json['fullAddress'];
    sate = json['sate'];
    city = json['city'];
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fullAddress'] = fullAddress;
    data['sate'] = sate;
    data['city'] = city;
    data['pin'] = pin;
    return data;
  }
}
