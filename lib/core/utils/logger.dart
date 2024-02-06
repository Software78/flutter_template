import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class DebugLogger {
  static void log(String tag, dynamic msg, {Object? error}) {
    if (kDebugMode) {
      developer.log('$msg', time: DateTime.now(), name: tag, error: error);
    }
  }
}
