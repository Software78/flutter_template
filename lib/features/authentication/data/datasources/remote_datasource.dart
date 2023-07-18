// ignore_for_file: unused_field

import 'package:dio/dio.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';

import '../../../../core/utils/functions.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({Dio? dio})
      : _dio = dio ?? Dio()
          ..interceptors.add(dioLogger())
          ..interceptors.add(DioFirebasePerformanceInterceptor())
          ..options.baseUrl = ''
          ..options.connectTimeout = const Duration(milliseconds: 60000)
          ..options.receiveTimeout = const Duration(milliseconds: 60000)
          ..options.sendTimeout = const Duration(milliseconds: 60000);
  final Dio _dio;
}
