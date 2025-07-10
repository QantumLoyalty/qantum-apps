import 'package:flutter/material.dart';
import 'package:qantum_apps/views/common_widgets/AppLoader.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../views/common_widgets/AppScaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  String url;

  AppWebView({super.key, required this.url});

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  late WebViewController _controller;
  bool showLoader = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (String url) {
        setState(() {
          showLoader = false;
        });
      }))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                size: 28,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              )),
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
            showLoader
                ? Center(
                    child: AppLoader(
                      loaderMessage: "Loading..",
                    ),
                  )
                : Container()
          ],
        ));
  }
}
