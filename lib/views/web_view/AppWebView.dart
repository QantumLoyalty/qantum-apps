import 'package:flutter/material.dart';
import 'package:qantum_apps/core/mixins/logging_mixin.dart';
import 'package:qantum_apps/l10n/app_localizations.dart';
import '../../views/common_widgets/AppLoader.dart';
import '../../views/common_widgets/AppScaffold.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView extends StatefulWidget {
  String url;

  AppWebView({super.key, required this.url});

  @override
  State<AppWebView> createState() => _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> with LoggingMixin {
  late WebViewController _controller;
  bool showLoader = true;
  bool showWebView = false;

  @override
  void initState() {
    super.initState();

    logEvent("WEB VIEW URL: ${widget.url}");

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(onPageFinished: (String url) {
        if (mounted) {
          setState(() {
            showLoader = false;
          });
        }
      }));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      setState(() {
        showWebView = true;
      });

      _controller.loadRequest(Uri.parse(widget.url));
    });
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
                      loaderMessage: AppLocalizations.of(context)!.txtLoading,
                    ),
                  )
                : Container()
          ],
        ));
  }
}
