import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/app_theme_custom.dart';
import '/data/models/AppUpdateResult.dart';
import '/views/common_widgets/AppButton.dart';
import '../../core/extensions/spacer_extension.dart';
import '/core/extensions/log_extension.dart';
import '/core/flavors_config/app_config.dart';
import 'package:url_launcher/url_launcher.dart';
import '/core/mixins/logging_mixin.dart';

import '/core/utils/AppDimens.dart';

import '../../l10n/app_localizations.dart';
import '../../view_models/UserInfoProvider.dart';

class AppUpdateDialog with LoggingMixin {
  static final AppUpdateDialog _instance = AppUpdateDialog._internal();

  static getInstance() {
    return _instance;
  }

  AppUpdateDialog._internal();

  bool _isDialogShowing = false;

  showAppUpdateDialog(BuildContext context,
      {required AppUpdateResult result}) async {
    if (_isDialogShowing || !context.mounted) {
      "AppUpdateDialog ignored because it is already showing".logMessage();
      return;
    }
    _isDialogShowing = true;
    try {
      context.read<UserInfoProvider>().getAppInfo();
      AppLocalizations loc = AppLocalizations.of(context)!;
      await showGeneralDialog(
          context: context,
          barrierDismissible: false,
          transitionDuration: const Duration(milliseconds: 250),
          pageBuilder: (context, anim1, anim2) {
            return PopScope(
              canPop: false,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                insetPadding: const EdgeInsets.all(20),
                backgroundColor: Theme.of(context).primaryColor,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      10.h,
                      Material(
                        color: AppThemeCustom.getAppUpdateLogoBackColor(context),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200),
                              side: BorderSide(
                                width: 1,
                                color: AppThemeCustom.getAppUpdateLogoBackColor(context),
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.download,
                              size: 48,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                            ),
                          )),
                      20.h,
                      Text(
                        "App Update Available".toUpperCase(),
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontWeight: FontWeight.bold),
                      ),
                      AppDimens.shape_10,
                      Text(
                          "Great news! A new update is available,\nclick the button to update now.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.normal)),
                      AppDimens.shape_10,
                      /*Text(loc.msgNewAppVersionAvailable
                        .replaceAll("###", "1.0.11")),
                    AppDimens.shape_10,
                    Selector<UserInfoProvider, String?>(
                        builder: (_, version, __) => Text(
                              loc.msgYouHaveVersion
                                  .replaceAll("###", version ?? ""),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                        selector: (_, v) => v.version),
                    AppDimens.shape_10,
                    Text(loc.msgLikeToUpdate),
                    AppDimens.shape_10,
                    Text(
                      loc.releaseNotes,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const Text("Minor updates & improvements"),*/
                      AppDimens.shape_10,
                      Row(
                        children: [
                          (!result.forceUpdate)
                              ? Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(loc.later,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .textSelectionTheme
                                                  .selectionColor,
                                              fontWeight: FontWeight.normal))))
                              : const SizedBox.shrink(),
                          Expanded(
                              child: AppButton(
                            onClick: () async {
                              final info = await PackageInfo.fromPlatform();
                              final id = info.packageName;

                              final Uri androidUrl = Uri.parse(
                                "market://details?id=$id",
                              );

                              final Uri androidFallback = Uri.parse(
                                "https://play.google.com/store/apps/details?id=$id",
                              );

                              final Uri iosUrl = Uri.parse(
                                AppConfig.iosAppStoreUrl,
                              );

                              try {
                                if (Platform.isAndroid) {
                                  if (await canLaunchUrl(androidUrl)) {
                                    await launchUrl(androidUrl);
                                  } else {
                                    /// IF PLAYSTORE APP ISN'T INSTALLED OR FAILED TO FIND THE PLAYSTORE APP THIS WILL WORK IN WEB VIEW
                                    await launchUrl(androidFallback,
                                        mode: LaunchMode.externalApplication);
                                  }
                                } else if (Platform.isIOS) {
                                  "iosUrl:; $iosUrl".logMessage();

                                  await launchUrl(iosUrl,
                                      mode: LaunchMode.externalApplication);
                                }
                              } catch (e) {
                                logEvent(
                                    "Error while opening the store: ${e.toString()}");
                              }
                            },
                            text: loc.updateNow.toUpperCase(),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
              child: SlideTransition(
                position:
                    Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                        .animate(anim1),
                child: child,
              ),
            );
          });
    } catch (e) {
      e.logMessage();
    } finally {
      _isDialogShowing = false;
    }
  }
}
