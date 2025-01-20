import 'package:flutter/foundation.dart';

mixin LoggingMixin {
  void logEvent(dynamic printableItem) {
    if (kDebugMode) {
      print(printableItem);
    }
  }
}
