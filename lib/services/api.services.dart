// import 'package:dio/dio.dart';

// class APIClient {
//   final Dio dio =
//       Dio(BaseOptions(baseUrl: "https://fideos-gamma.vercel.app/api/v1"));

//   Future<Response<T>> get<T>(String path,
//       {Map<String, dynamic>? queryParameters}) async {
//     return await dio.get<T>(path, queryParameters: queryParameters);
//   }

//   Future<Response<T>> post<T>(String path, {dynamic data}) async {
//     return await dio.post<T>(path, data: data);
//   }

//   Future<Response<T>> put<T>(String path, {Map<String, dynamic>? data}) async {
//     return await dio.put<T>(path, data: data);
//   }
// }

import 'dart:developer';
import 'package:dio/dio.dart';

class APIClient {
  String baseURL = "https://fideos-node.vercel.app/api/v1";
  String endpoint = "";
  Dio dio = Dio();
  APIClient(this.endpoint) {
    dio = Dio(BaseOptions(
      baseUrl: baseURL,
      headers: {
        'Content-Type': 'application/json',
      },
      responseType: ResponseType.json,
    ));
  }

  Future<Response?> get({String? id}) async {
    try {
      String url = id != null ? '$endpoint/$id' : endpoint;
      log(this.baseURL + url);
      final response = await dio.get(url);
      return response;
    } catch (e) {
      log("API Error: $e");
      return null;
    }
  }

  Future<Response?> post(dynamic data) async {
    return await dio.post(endpoint, data: data);
  }
}
