import 'package:shared_preferences/shared_preferences.dart';

import 'storage_client.dart';

class PrefsStorageImpl implements StorageClient {
  @override
  Future deleteAll({List<String> ignoredKeys = const []}) {
    return SharedPreferences.getInstance().then((prefs) {
      final keys = prefs.getKeys();
      for (final key in keys) {
        if (!ignoredKeys.contains(key)) {
          prefs.remove(key);
        }
      }
    });
  }

  @override
  Future<T?> read<T>(String key) {
    return SharedPreferences.getInstance().then((prefs) {
      if (T.runtimeType == String) {
        return prefs.getString(key) as T;
      } else if (T.runtimeType == int) {
        return prefs.getInt(key) as T;
      } else if (T.runtimeType == double) {
        return prefs.getDouble(key) as T;
      } else if (T.runtimeType == bool) {
        return prefs.getBool(key) as T;
      } else if (T.runtimeType == List<String>) {
        return prefs.getStringList(key) as T;
      } else {
        throw Exception('Type not found');
      }
    });
  }

  @override
  Future write<T>(String key, T value) {
    return SharedPreferences.getInstance().then((prefs) {
      if (T.runtimeType == String) {
        return prefs.setString(key, value as String);
      } else if (T.runtimeType == int) {
        return prefs.setInt(key, value as int);
      } else if (T.runtimeType == double) {
        return prefs.setDouble(key, value as double);
      } else if (T.runtimeType == bool) {
        return prefs.setBool(key, value as bool);
      } else if (T.runtimeType == List<String>) {
        return prefs.setStringList(key, value as List<String>);
      } else {
        throw Exception('Type not found');
      }
    });
  }

  @override
  Future delete(String key) {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.remove(key);
    });
  }
}
