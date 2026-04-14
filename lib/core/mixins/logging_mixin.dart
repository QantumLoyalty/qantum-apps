import 'package:flutter/foundation.dart';
import 'package:qantum_apps/core/flavors_config/flavor_config.dart';
mixin LoggingMixin {
  void logEvent(dynamic printableItem) {
    if (kDebugMode) {
      print(printableItem);
    }
  }
  Flavor get flavor => FlavorConfig.instance.flavor!;

}
