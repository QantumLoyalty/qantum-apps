import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/mixins/logging_mixin.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/core/utils/AppIcons.dart';
import 'package:qantum_apps/core/utils/AppStrings.dart';
import 'package:qantum_apps/view_models/HomeProvider.dart';
import 'package:qantum_apps/view_models/UserInfoProvider.dart';
import 'package:qantum_apps/views/dialogs/MyProfileDialog.dart';
import 'package:screen_brightness/screen_brightness.dart';

import '../../dialogs/DigitalCardDialog.dart';

class HomeAppBar extends StatelessWidget with LoggingMixin {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppDimens.shape_10,
          const Divider(
            thickness: 0.5,
            height: 0.5,
          ),
          AppDimens.shape_10,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Consumer<UserInfoProvider>(
                          builder: (context, provider, child) {
                        return InkWell(
                          onTap: () async {
                            double screenBrightness = 0.4;

                            try {
                              screenBrightness =
                                  await ScreenBrightness.instance.system;
                            } catch (e) {
                              logEvent(e);
                              throw 'Failed to get system brightness';
                            }

                            logEvent("SCREEN BRIGHTNESS:: $screenBrightness");

                            try {
                              await ScreenBrightness.instance
                                  .setSystemScreenBrightness(1);
                            } catch (e) {
                              debugPrint(e.toString());
                              //throw 'Failed to set application brightness';
                            }

                            await DigitalCardDialog.getInstance()
                                .showDigitalCardDialog(context);

                            try {
                              await ScreenBrightness.instance
                                  .setSystemScreenBrightness(screenBrightness);
                            } catch (e) {
                              logEvent(e.toString());
                              // throw 'Failed to reset application brightness';
                            }
                          },
                          child: SizedBox(
                            width: 80,
                            height: 50,
                            child: Stack(
                              children: [
                                (provider.getUserInfo != null)
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          AppIcons.getCardBackground(
                                              provider.getUserInfo!.statusTier),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppStrings.txtMyCard.toUpperCase(),
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                            offset: const Offset(1.0, 1.0),
                                            blurRadius: 3.0,
                                            color: AppColors.black
                                                .withValues(alpha: 0.5),
                                          )
                                        ],
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    AppIcons.app_logo,
                    width: 80,
                    height: 80,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Consumer<HomeProvider>(
                            builder: (context, provider, child) {
                          return InkWell(
                            onTap: () {
                              //   provider.openMyProfileScreen();
                              MyProfileDialog.getInstance()
                                  .showMyProfileDialog(context);
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppIcons.my_profile,
                                  width: 36,
                                  height: 36,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                Text(
                                  AppStrings.txtMyProfile.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.normal,
                                      color: Theme.of(context)
                                          .textSelectionTheme
                                          .selectionColor),
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
