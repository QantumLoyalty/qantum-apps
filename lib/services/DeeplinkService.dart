import 'dart:async';
import 'package:app_links/app_links.dart';

class DeeplinkService {
  DeeplinkService._internal();
  static final DeeplinkService _instance = DeeplinkService._internal();
  factory DeeplinkService() => _instance;

  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _uriLinkSub;

  Function(Uri uri)? _onLink;
  bool _listening = false;

  String? _lastHandledKey;
  DateTime? _lastHandledTime;

  Future<void> init(Function(Uri uri) onLink) async {
    _onLink = onLink;

    if (_listening) return;
    _listening = true;

    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      _emitIfFresh(initialUri, source: "INITIAL");
    }

    await _uriLinkSub?.cancel();
    _uriLinkSub = _appLinks.uriLinkStream.listen((uri) {
      _emitIfFresh(uri, source: "STREAM");
    });
  }

  void _emitIfFresh(Uri uri, {required String source}) {
    final now = DateTime.now();
    final key = _normalizedKey(uri);

    print("[$source] raw uri: ${uri.toString()}");
    print("[$source] key: $key");

    if (_lastHandledKey == key &&
        _lastHandledTime != null &&
        now.difference(_lastHandledTime!) < const Duration(seconds: 2)) {
      print("DUPLICATE DEEPLINK IGNORED FROM $source");
      return;
    }

    _lastHandledKey = key;
    _lastHandledTime = now;

    _onLink?.call(uri);
  }

  String _normalizedKey(Uri uri) {
    final inner = uri.queryParameters['link'];
    if (inner != null && inner.isNotEmpty) {
      return Uri.decodeComponent(inner);
    }
    return uri.toString();
  }

  Future<void> dispose() async {
    await _uriLinkSub?.cancel();
    _uriLinkSub = null;
    _listening = false;
    _onLink = null;
  }
}