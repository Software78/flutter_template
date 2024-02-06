import 'package:dio/dio.dart';
import 'package:flutter_project_template/core/api/response/api_response.dart';

import '../../../config/flavor/build_variables.dart';
import 'api_client.dart';

class DioApiClient implements ApiClient {
  late Dio _dio;

  DioApiClient() {
    _dio = Dio(BaseOptions(
      baseUrl: buildVariables.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    ));
  }

  @override
  void removeToken() {
    _dio.options.headers.remove('Authorization');
  }

  @override
  Future<ApiResponse<T>> request<T>(String path,
      {required MethodType method,
      Map<String, dynamic>? payload,
      Map<String, dynamic>? queryParameters,
      T Function(Map<String, dynamic> json)? fromJson}) async {
    try {
      Response response;
      switch (method) {
        case MethodType.get:
          response = await _dio.get(path,
              data: payload, queryParameters: queryParameters);
          break;
        case MethodType.post:
          response = await _dio.post(path,
              data: payload, queryParameters: queryParameters);
          break;
        case MethodType.put:
          response = await _dio.put(path,
              data: payload, queryParameters: queryParameters);
          break;
        case MethodType.delete:
          response = await _dio.delete(path,
              data: payload, queryParameters: queryParameters);
          break;
        case MethodType.patch:
          response = await _dio.patch(path,
              data: payload, queryParameters: queryParameters);
          break;
      }
      return ApiResponse<T>(
        data: fromJson != null ? fromJson(response.data) : null,
        isSuccess: true,
      );
    } on DioException catch (e) {
      return ApiResponse.error(
        message: e.response?.data['message'] ?? e.message,
      );
    }
  }

  @override
  void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
}
