import 'package:flutter/foundation.dart';

extension LogExtension on Object? {
  void logMessage([String tag = "LOG"]) {
    if (kDebugMode) {
      debugPrint("🔹 $tag :: $this", wrapWidth: 1024);
    }
  }
}
