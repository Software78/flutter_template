// ignore_for_file: unused_field

import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({Future<SharedPreferences>? preferences})
      : _preferences = preferences ?? SharedPreferences.getInstance();
  final Future<SharedPreferences> _preferences;
}
