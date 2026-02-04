import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';


class InternetStatusProvider extends ChangeNotifier {
  bool _hasInternet = true;

  bool get hasInternet => _hasInternet;
  late final StreamSubscription _subscription;

  InternetStatusProvider() {
    _subscription = Connectivity().onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final connected = !results.contains(ConnectivityResult.none);

    if (_hasInternet != connected) {
      _hasInternet = connected;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
