import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

Dio dio = Dio(
  BaseOptions(
      baseUrl: 'http://f030-82-26-171-54.ngrok-free.app/api',
      responseType: ResponseType.plain,
      validateStatus: (int? status) {
        return status != null;
        // return status != null && status >= 200 && status < 300;
      },
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      }),
)
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      const storage = FlutterSecureStorage();
      storage.read(key: 'auth').then(
        (token) {
          options.headers['Authorization'] = 'Bearer $token';
          handler.next(options);
        },
      );
    },
  ))
  ..interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: true,
    responseHeader: true,
    error: true,
    compact: true,
  ));
