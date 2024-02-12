import 'package:dio/dio.dart';
import 'package:fluttersanctum/providers/auth.dart';

Dio dio() {
  var dio = Dio(
    BaseOptions(
        baseUrl: 'http://127.0.0.1:8000/api',
        responseType: ResponseType.plain,
        validateStatus: (int? status) {
          return status != null;
          // return status != null && status >= 200 && status < 300;
        },
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        requestInterceptor(options);
        return handler.next(options);
      },
    ),
  );

  return dio;
}

dynamic requestInterceptor(RequestOptions options) async {
  var token = await Auth().getToken();
  if (token != null) {
    print("Token $token");
    options.headers.addAll({'Authorization': 'Bearer $token'});
    print('Headers: ${options.headers}');
  }
  return options;
}
