import 'dart:convert';
import 'package:dio/dio.dart' as dio_http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttersanctum/dio.dart';
import 'package:fluttersanctum/models/user.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Auth extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  bool _authenticated = false;
  late User _user;

  bool get isAuthenticated => _authenticated;
  User get user => _user;

  Future login({required Map credentials}) async {
    String deviceId = await getDeviceId();
    dio_http.Response response = await dio.post(
      '/auth/token',
      data: json.encode(credentials..addAll({'deviceId': deviceId})),
    );
    String token = json.decode(response.toString())['token'];
    dio.options.headers['Authorization'] = 'Bearer $token';
    storetoken(token);
  }

  Future attempt(String token) async {
    try {
      debugPrint('Token $token');
      dio_http.Response response = await dio.get('/auth/user',
          options: dio_http.Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ));

      if (response.statusCode == 200) {
        _user = User.fromJson(json.decode(response.toString()));
        _authenticated = true;
      } else {
        // Handle unexpected status codes
        _authenticated = false;
        debugPrint('Unexpected status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle Dio errors
      _authenticated = false;
      debugPrint('Dio error: $e');
    }
    notifyListeners();
  }

  storetoken(String token) async {
    await storage.write(key: 'auth', value: token);
  }

  Future getToken() async {
    return await storage.read(key: 'auth');
  }

  Future getDeviceId() async {
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    return deviceId;
  }

  void logout() {
    _authenticated = false;
    notifyListeners();
  }
}
