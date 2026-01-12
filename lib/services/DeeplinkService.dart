import 'package:app_links/app_links.dart';

class DeeplinkService {
  final AppLinks _appLinks = AppLinks();

  void init(Function(Uri uri) onLink) {

    /// COLD START APP IS IN CLOSED STATE
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        onLink(uri);
      }
    });

    /// APP ALREADY RUNNING AND OPENED IN BACKGROUND
    _appLinks.uriLinkStream.listen((uri) {
      onLink(uri);
    });
  }
}
