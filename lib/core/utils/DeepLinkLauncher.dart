import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

import '../extensions/log_extension.dart';

class DeepLinkLauncher {
  static Future<void> launchChewzieUrl(
      BuildContext context,
      Uri uri,
      Color toolbarColor
      ) async {
    try {
      debugPrint("Launching deep link URL: $uri");

      if (Platform.isIOS) {
        try {
          await closeCustomTabs();
          await Future.delayed(const Duration(milliseconds: 250));
        } catch (_) {
          // ignore; there may be nothing open
        }
      }

      await launchUrl(uri,
          customTabsOptions: CustomTabsOptions(
            showTitle: false,
            urlBarHidingEnabled: true,
            shareState: CustomTabsShareState.off,
            colorSchemes: CustomTabsColorSchemes.defaults(
              toolbarColor: toolbarColor
            ),
          ),
          safariVCOptions: SafariViewControllerOptions(
            barCollapsingEnabled: true,
            preferredBarTintColor: toolbarColor,
            dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          ));
    } catch (e) {
      e.toString().logMessage("LAUNCH URL EXCEPTION");
    }
  }
}