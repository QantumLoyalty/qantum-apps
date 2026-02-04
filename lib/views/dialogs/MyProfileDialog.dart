import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/view_models/HomeProvider.dart';
import 'package:qantum_apps/views/common_widgets/AppLoader.dart';
import '../../core/utils/AppColors.dart';
import '/views/common_widgets/UserStatusTier.dart';
import '/l10n/app_localizations.dart';
import '../../core/mixins/logging_mixin.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/flavors_config/flavor_config.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../data/local/SharedPreferenceHelper.dart';
import '../../view_models/UserInfoProvider.dart';
import '../common_widgets/IconTextWidget.dart';

class MyProfileDialog with LoggingMixin {
  static final MyProfileDialog _myProfileDialog = MyProfileDialog._internal();

  static MyProfileDialog getInstance() {
    return _myProfileDialog;
  }

  MyProfileDialog._internal();

  static const double dialogHeightFactor = 0.90;
  static const double dialogHeightBottomMargin = 80;
  late Flavor flavor;

  showMyProfileDialog(BuildContext context) async {
    flavor = FlavorConfig.instance.flavor!;
    SharedPreferenceHelper sharedPreferenceHelper =
        await SharedPreferenceHelper.getInstance();
    AppLocalizations loc = AppLocalizations.of(context)!;
    Provider.of<UserInfoProvider>(context, listen: false).getAppInfo();

    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, anim1, anim2) {
          logEvent(FlavorConfig.instance.flavorValues.appVersion);

          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  height:
                      MediaQuery.of(context).size.height * dialogHeightFactor,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                flavor == Flavor.kingscliff? AppColors.kc_primary_color:AppThemeCustom.getMyProfileCardBackground(context),
                                flavor == Flavor.kingscliff? AppColors.kc_primary_color_dark:AppThemeCustom.getMyProfileCardBackground(context),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height *
                                dialogHeightFactor -
                            dialogHeightBottomMargin,
                        child: Consumer<UserInfoProvider>(
                            builder: (context, provider, child) {
                          return Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          AppDimens.shape_20,
                                          flavor == Flavor.bluewater
                                              ? Image.asset(
                                                  "assets/bluewaterCaptainsClub/captains_cap.png",
                                                  width: 80,
                                                  height: 80,
                                                  color: Theme.of(context)
                                                      .canvasColor
                                                      .withValues(alpha: 0.3),
                                                )
                                              : Icon(
                                                  Icons.person,
                                                  color: AppThemeCustom
                                                      .getProfileDialogImage(
                                                          context),
                                                  size: 40,
                                                ),
                                          Text(
                                            "${provider.getUserInfo?.firstName ?? ''} ${provider.getUserInfo?.lastName ?? ''}",
                                            textAlign: TextAlign.center,
                                            textScaler: const TextScaler.linear(1.0),
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: AppThemeCustom.getProfileDialogTextColor(context),
                                            ),
                                          ),
                                          Text(
                                            "${loc.txtCard} # ${provider.getUserInfo?.cardNumber ?? ''}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: AppThemeCustom.getProfileDialogCardTextColor(context),
                                            ),
                                          ),
                                          AppDimens.shape_20,
                                          IconTextWidget(
                                            orientation:
                                                IconTextWidget.HORIZONTAL,
                                            icon: Icons.cake,
                                            iconSize: 18,
                                            text: AppHelper.formatDate(provider
                                                .getUserInfo!.dateOfBirth),
                                            iconColor: AppThemeCustom
                                                .getProfileDialogTextColor(
                                                    context),
                                            textColor: AppThemeCustom
                                                .getProfileDialogTextColor(
                                                    context),
                                          ),
                                          IconTextWidget(
                                            orientation:
                                                IconTextWidget.HORIZONTAL,
                                            icon: Icons.phone_android_outlined,
                                            iconSize: 18,
                                            text:
                                                "${provider.getUserInfo!.mobile}",
                                            iconColor: AppThemeCustom
                                                .getProfileDialogTextColor(
                                                    context),
                                            textColor: AppThemeCustom
                                                .getProfileDialogTextColor(
                                                    context),
                                          ),
                                          IconTextWidget(
                                            orientation:
                                                IconTextWidget.HORIZONTAL,
                                            icon: Icons.email_outlined,
                                            iconSize: 18,
                                            text:
                                                "${provider.getUserInfo!.email}",
                                            iconColor: AppThemeCustom
                                                .getProfileDialogTextColor(
                                                    context),
                                            textColor: AppThemeCustom
                                                .getProfileDialogTextColor(
                                                    context),
                                          ),
                                          AppDimens.shape_10,
                                          OutlinedButton(
                                              style: OutlinedButton.styleFrom(
                                                  padding: EdgeInsets.zero,
                                                  minimumSize:
                                                      const Size(80, 40),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  side: BorderSide(
                                                      width: 1,
                                                      color: AppThemeCustom
                                                          .getEditDetailsColor(
                                                              context))),
                                              onPressed: () {
                                                AppNavigator.navigateTo(
                                                    context,
                                                    AppNavigator
                                                        .userDetailScreen);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.handshake,
                                                      color: AppThemeCustom
                                                          .getEditDetailsColor(
                                                              context),
                                                      size: 18,
                                                    ),
                                                    Text(
                                                      loc.txtEditMyDetails
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                          color: AppThemeCustom
                                                              .getEditDetailsColor(
                                                                  context,isText:true),
                                                          fontSize: 10),
                                                    )
                                                  ],
                                                ),
                                              )),
                                          (flavor == Flavor.clh ||
                                                  flavor ==
                                                      Flavor.montaukTavern ||
                                                  flavor == Flavor.starReward ||
                                                  flavor == Flavor.flinders)
                                              ? Container()
                                              : UserStatusTier()
                                        ],
                                      ),
                                    ),
                                  ),
                                  AppDimens.shape_10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Consumer<UserInfoProvider>(
                                          builder: (context, provider, child) {
                                        if (provider.cancelledAccount != null &&
                                            provider.cancelledAccount!) {
                                          /// ACCOUNT IS CANCELLED, DO LOGOUT & REDIRECT TO LOGIN SCREEN
                                          /// CLEARING ALL PREFERENCES

                                          sharedPreferenceHelper.clearAll();

                                          /// REMOVING ALL DIALOGS
                                          Navigator.pop(context);

                                          /// NAVIGATING TO LOGIN SCREEN
                                          Future.delayed(Duration.zero, () {
                                            provider.resetCancelledAccount();
                                            AppNavigator.navigateAndClearStack(
                                                context, AppNavigator.login);
                                          });
                                        }

                                        return InkWell(
                                          onTap: () async {
                                            var response = await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(loc.txtAlert),
                                                    content: Text(
                                                        loc.msgCancelAccount),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context, false);
                                                          },
                                                          child: Text(
                                                            loc.txtNo,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                          )),
                                                      TextButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context, true);
                                                          },
                                                          child: Text(
                                                            loc.txtYes,
                                                            style: TextStyle(
                                                                color: AppThemeCustom
                                                                    .getAlertDialogTextButtonColor(
                                                                        context)),
                                                          )),
                                                    ],
                                                  );
                                                });

                                            if (response) {
                                              /// CANCEL ACCOUNT ///
                                              provider.cancelAccount();
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  loc.txtDeleteMyAccount
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: AppThemeCustom
                                                          .getProfileDialogTextColor(
                                                              context)),
                                                ),
                                                AppDimens.shape_10,
                                                (provider.showCancelAccountLoader !=
                                                            null &&
                                                        provider
                                                            .showCancelAccountLoader!)
                                                    ? const SizedBox(
                                                        width: 15,
                                                        height: 15,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                        ),
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                      Consumer<UserInfoProvider>(
                                          builder: (context, provider, child) {
                                        if (provider.logoutSuccess != null) {
                                          if (provider.logoutSuccess!) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                                    (_) async {
                                              try {
                                                /// CLEARING ALL PREFERENCE
                                                SharedPreferenceHelper
                                                    sharedPreferenceHelper =
                                                    await SharedPreferenceHelper
                                                        .getInstance();
                                                await sharedPreferenceHelper
                                                    .clearAll();

                                                /// CANCELLING ALL TIMER/REPEATED TASKS IN PROVIDERS

                                                await closingAllRepeatedTasksInProviders(
                                                    context);

                                                /// REMOVING PROFILE DIALOG
                                                Navigator.pop(context);

                                                /// NAVIGATING TO LOGIN SCREEN
                                                AppNavigator
                                                    .navigateReplacement(
                                                        context,
                                                        AppNavigator.login);
                                                provider.resetLogoutStatus();
                                              } catch (e) {}
                                            });
                                          }
                                        }

                                        return InkWell(
                                          onTap: () async {
                                            final confirmedLogout =
                                                await showDialog<bool>(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title:
                                                            Text(loc.txtAlert),
                                                        content:
                                                            Text(loc.msgLogout),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                              },
                                                              child: Text(
                                                                loc.txtNo,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              )),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);
                                                              },
                                                              child: Text(
                                                                loc.txtYes,
                                                                style: TextStyle(
                                                                    color: AppThemeCustom
                                                                        .getAlertDialogTextButtonColor(
                                                                            context)),
                                                              )),
                                                        ],
                                                      );
                                                    });

                                            if (confirmedLogout != true) {
                                              return;
                                            } else {
                                              provider.logoutUser();
                                            }

                                            /*try {
                                                  /// CLEARING ALL PREFERENCE
                                                  SharedPreferenceHelper
                                                      sharedPreferenceHelper =
                                                      await SharedPreferenceHelper
                                                          .getInstance();
                                                  await sharedPreferenceHelper
                                                      .clearAll();

                                                  /// CANCELLING ALL TIMER/REPEATED TASKS IN PROVIDERS

                                                  await closingAllRepeatedTasksInProviders(
                                                      context);

                                                  /// REMOVING PROFILE DIALOG
                                                  Navigator.pop(context);

                                                  /// NAVIGATING TO LOGIN SCREEN
                                                  AppNavigator.navigateReplacement(
                                                      context, AppNavigator.login);
                                                } catch (e) {}*/
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                              loc.txtLogout.toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
                                                  color: AppThemeCustom
                                                      .getProfileDialogTextColor(
                                                          context)),
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                              provider.showLogoutLoader != null &&
                                      provider.showLogoutLoader!
                                  ? AppLoader(
                                      loaderMessage: loc.logoutMessage,
                                    )
                                  : Container(),
                              (flavor == Flavor.aceRewards)
                                  ? Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: IgnorePointer(
                                        child: Opacity(
                                            opacity: 0.4,
                                            child: Image.asset(
                                                "assets/aceRewards/scaffold_background.png")),
                                      ))
                                  : Container()
                            ],
                          );
                        }),
                      ),
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 50,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Selector<UserInfoProvider, String?>(
                                  builder: (_, version, __) => Text(
                                        "V $version",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: AppThemeCustom
                                                .getProfileDialogTextColor(
                                                    context)),
                                      ),
                                  selector: (_, v) => v.version),
                              CircleAvatar(
                                backgroundColor:
                                    AppThemeCustom.getMyProfileCardBackground(
                                        context),
                                radius: 30,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      size: 30,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          ))
                    ],
                  ),
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
  }

  closingAllRepeatedTasksInProviders(BuildContext context) async {
    await Provider.of<UserInfoProvider>(context, listen: false)
        .stopFetchProfileTimer();

    await Provider.of<HomeProvider>(context, listen: false)
        .stopGetAllOptionsTimer();
  }
}
