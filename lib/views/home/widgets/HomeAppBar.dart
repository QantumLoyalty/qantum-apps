import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/AppColors.dart';
import '/core/utils/AppHelper.dart';
import '../../../core/flavors_config/app_theme_custom.dart';
import '../../../l10n/app_localizations.dart';
import '/core/mixins/logging_mixin.dart';
import '/core/utils/AppDimens.dart';
import '/core/utils/AppIcons.dart';
import '/view_models/HomeProvider.dart';
import '/view_models/UserInfoProvider.dart';
import '/views/dialogs/MyProfileDialog.dart';
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
                      Consumer2<UserInfoProvider, HomeProvider>(
                          builder: (context, provider, homeProvider, child) {
                        return InkWell(
                          onTap: () async {
                            /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                            if (homeProvider.showSeeAllMenu) {
                              homeProvider.updateShowAllMenuVisibility(
                                  false, "my card");
                            }

                            double screenBrightness = 0.4;

                            try {
                              screenBrightness =
                                  await ScreenBrightness.instance.system;
                            } catch (e) {
                              logEvent(e);
                              throw 'Failed to get system brightness';
                            }

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
                                              AppHelper.getUserTierType(
                                                  provider.getUserInfo!)),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .txtMyCard
                                        .toUpperCase(),
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
                                      color: AppThemeCustom
                                          .getCardDialogsTextColor(context),
                                    ),
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
                    AppIcons.getHeaderIcon(),
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
                              /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                              if (provider.showSeeAllMenu) {
                                provider.updateShowAllMenuVisibility(
                                    false, "my profile");
                              }
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
                                  width: 34,
                                  height: 34,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .txtMyProfile
                                      .toUpperCase(),
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
