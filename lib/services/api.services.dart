import 'package:dio/dio.dart';

class APIClient {
  final Dio dio =
      Dio(BaseOptions(baseUrl: "https://fideos-gamma.vercel.app/api/v1"));

  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return await dio.get<T>(path, queryParameters: queryParameters);
  }

  Future<Response<T>> post<T>(String path, {dynamic data}) async {
    return await dio.post<T>(path, data: data);
  }

  Future<Response<T>> put<T>(String path, {Map<String, dynamic>? data}) async {
    return await dio.put<T>(path, data: data);
  }
}
