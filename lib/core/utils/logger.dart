import 'dart:developer' as developer;

class DebugLogger {
  static void log(String tag, dynamic msg, {Object? error}) {
    developer.log('$msg', time: DateTime.now(), name: tag, error: error);
  }
}
