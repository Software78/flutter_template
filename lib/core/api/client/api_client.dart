import '../response/api_response.dart';

abstract class ApiClient {
  void setToken(String token);
  void removeToken();
  Future<ApiResponse<T>> request<T>(
    String path, {
    required MethodType method,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic> json)? fromJson,
  });
}

enum MethodType { get, post, put, delete, patch }
