import 'package:dio/dio.dart';

Dio dio = Dio(
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
