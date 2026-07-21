import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/flavor_config.dart';
import 'package:qantum_apps/data/local/SharedPreferenceHelper.dart';
import 'package:qantum_apps/views/home/notification_screen.dart';
import '/core/utils/AppHelper.dart';
import '/views/dialogs/MembershipCancelledDialog.dart';
import 'package:screen_brightness/screen_brightness.dart';
import '/core/mixins/logging_mixin.dart';
import '/core/utils/AppDimens.dart';
import '/core/utils/AppIcons.dart';
import '/view_models/HomeProvider.dart';
import '/view_models/UserInfoProvider.dart';
import '/views/dialogs/MyProfileDialog.dart';
import '../../../core/flavors_config/app_theme_custom.dart';
import '../../../core/utils/AppColors.dart';
import '../../../core/utils/FlavorConstants.dart';
import '../../../l10n/app_localizations.dart';
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


                            try {
                              await ScreenBrightness.instance
                                  .setApplicationScreenBrightness(1);
                            } catch (e) {
                              debugPrint(e.toString());
                            }
                            if (provider.getUserInfo!.isUserStatusCancelled()) {
                              await MembershipCancelledDialog.getInstance()
                                  .showMembershipCancelledDialog(context);
                            } else {
                              await DigitalCardDialog.getInstance()
                                  .showDigitalCardDialog(context);
                            }

                            try {
                              await ScreenBrightness.instance
                                  .resetApplicationScreenBrightness();
                            } catch (e) {
                              logEvent(e.toString());
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
                                        child: Material(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: AppColors.white,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Image.asset(
                                              AppIcons.getCardBackground(
                                                  FlavorConstants
                                                      .getUserTierType(provider
                                                          .getUserInfo!)),
                                              fit: BoxFit.cover,
                                            )))
                                    : const SizedBox.shrink(),
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
                  child: Center(
                    child: SizedBox(
                      width: AppHelper.getAppIconSize(context).width,
                      height: AppHelper.getAppIconSize(context).height,
                      child: Image.asset(
                        AppIcons.getHeaderIcon(),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      /*if (flavor == Flavor.southportSharks)
                        Positioned(
                          right: 60, // profile column ki width + spacing ke hisaab se adjust karo
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: IconButton(
                              onPressed: () async {
                                final sph = await SharedPreferenceHelper.getInstance();
                                final currentUserId = sph.getUserData()?.id ?? 'guest';

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          NotificationsScreen(userId: currentUserId),
                                    ));
                              },
                              icon: Icon(
                                Icons.notifications_outlined,
                                color: AppThemeCustom.getHomeScreenProfileIconColor(context),
                                size: 34,
                              ),
                            ),
                          ),
                        ),
                      */
                      if (flavor == Flavor.southportSharks||flavor==Flavor.qantum)
                        Positioned(
                          right: 60,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: Consumer<HomeProvider>(
                              builder: (context, homeProvider, child) {
                                final unreadCount = homeProvider.unreadCount;
                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        final sph = await SharedPreferenceHelper.getInstance();
                                        final currentUserId = sph.getUserData()?.id ?? 'guest';

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  NotificationsScreen(userId: currentUserId),
                                            ));
                                      },
                                      icon: Icon(
                                        Icons.notifications_none_rounded,
                                        color: AppThemeCustom.getHomeScreenProfileIconColor(context),
                                        size: 36,
                                      ),
                                    ),
                                    if (unreadCount > 0)
                                      Positioned(
                                        right: 8,
                                        top: 10,
                                        child: Container(
                                          width: 18,
                                          height:18,
                                          constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(2000),
                                            border: Border.all(color: Colors.white, width: 1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              unreadCount > 99 ? '99+' : unreadCount.toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold,
                                               // height: 1.2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),



                      Consumer2<HomeProvider, UserInfoProvider>(
                        builder: (context, provider, userInfoProvider, child) {
                          return InkWell(
                            onTap: () {
                              if (userInfoProvider.getUserInfo != null &&
                                  !userInfoProvider.getUserInfo!.isUserStatusCancelled()) {
                                if (provider.showSeeAllMenu) {
                                  provider.updateShowAllMenuVisibility(false, "my profile");
                                }
                                MyProfileDialog.getInstance().showMyProfileDialog(context);
                              }
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
                                  color: (userInfoProvider.getUserInfo != null &&
                                      userInfoProvider.getUserInfo!.isUserStatusCancelled())
                                      ? AppColors.disable_color
                                      : AppThemeCustom.getHomeScreenProfileIconColor(context),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.txtMyProfile.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: (userInfoProvider.getUserInfo != null &&
                                          userInfoProvider.getUserInfo!.isUserStatusCancelled())
                                          ? AppColors.disable_color
                                          : Theme.of(context).textSelectionTheme.selectionColor),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
