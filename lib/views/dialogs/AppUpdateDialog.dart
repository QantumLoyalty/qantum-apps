import 'dart:io';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import '/core/extensions/log_extension.dart';
import '/core/flavors_config/app_config.dart';
import 'package:url_launcher/url_launcher.dart';
import '/core/mixins/logging_mixin.dart';
import '/core/flavors_config/flavor_config.dart';
import '/core/utils/AppDimens.dart';
import '../../core/utils/AppColors.dart';
import '../../l10n/app_localizations.dart';
import '../../view_models/UserInfoProvider.dart';

class AppUpdateDialog with LoggingMixin {
  static final AppUpdateDialog _instance = AppUpdateDialog._internal();

  static getInstance() {
    return _instance;
  }

  AppUpdateDialog._internal();

  showAppUpdateDialog(BuildContext context) {
    context.read<UserInfoProvider>().getAppInfo();
    AppLocalizations loc = AppLocalizations.of(context)!;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            insetPadding: const EdgeInsets.all(20),
            backgroundColor: AppColors.white,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    loc.appUpdate,
                    style: TextStyle(fontSize: 18, color: AppColors.black),
                  ),
                  AppDimens.shape_10,
                  Text(loc.msgNewVersionAvailable.replaceAll(
                      "###", FlavorConfig.instance.flavorValues.appName!)),
                  AppDimens.shape_10,
                  Text(loc.msgNewAppVersionAvailable
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
                  const Text("Minor updates & improvements"),
                  AppDimens.shape_10,
                  Row(
                    children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(loc.ignore,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(loc.later,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal)))),
                      Expanded(
                          child: TextButton(
                              onPressed: () async {
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
                              child: Text(loc.updateNow,
                                  style:
                                      const TextStyle(fontWeight: FontWeight.w700)))),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
