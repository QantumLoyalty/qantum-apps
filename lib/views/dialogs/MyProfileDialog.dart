import 'dart:ui';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/mixins/logging_mixin.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/flavors_config/flavor_config.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../core/utils/AppStrings.dart';
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

  showMyProfileDialog(BuildContext context) async {
    SharedPreferenceHelper sharedPreferenceHelper =
        await SharedPreferenceHelper.getInstance();

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
                  height: MediaQuery.of(context).size.height * dialogHeightFactor,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * dialogHeightFactor - dialogHeightBottomMargin,
                        child: Consumer<UserInfoProvider>(
                            builder: (context, provider, child) {
                          return Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      AppDimens.shape_20,
                                      Icon(
                                        Icons.person,
                                        color: AppThemeCustom
                                            .getProfileDialogImage(context),
                                        size: 40,
                                      ),
                                      Text(
                                        "${provider.getUserInfo!.firstName} ${provider.getUserInfo!.lastName}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                            color: AppThemeCustom
                                                .getProfileDialogTextColor(
                                                    context)),
                                      ),
                                      Text(
                                        "Card # ${provider.getUserInfo!.cardNumber}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppThemeCustom
                                                .getProfileDialogCardTextColor(
                                                    context)),
                                      ),
                                      AppDimens.shape_20,
                                      IconTextWidget(
                                        orientation: IconTextWidget.HORIZONTAL,
                                        icon: Icons.cake,
                                        iconSize: 18,
                                        text: AppHelper.formatDate(
                                            provider.getUserInfo!.dateOfBirth),
                                        iconColor: AppThemeCustom
                                            .getProfileDialogTextColor(context),
                                        textColor: AppThemeCustom
                                            .getProfileDialogTextColor(context),
                                      ),
                                      IconTextWidget(
                                        orientation: IconTextWidget.HORIZONTAL,
                                        icon: Icons.phone_android_outlined,
                                        iconSize: 18,
                                        text: "${provider.getUserInfo!.mobile}",
                                        iconColor: AppThemeCustom
                                            .getProfileDialogTextColor(context),
                                        textColor: AppThemeCustom
                                            .getProfileDialogTextColor(context),
                                      ),
                                      IconTextWidget(
                                        orientation: IconTextWidget.HORIZONTAL,
                                        icon: Icons.email_outlined,
                                        iconSize: 18,
                                        text: "${provider.getUserInfo!.email}",
                                        iconColor: AppThemeCustom
                                            .getProfileDialogTextColor(context),
                                        textColor: AppThemeCustom
                                            .getProfileDialogTextColor(context),
                                      ),
                                      AppDimens.shape_10,
                                      OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: const Size(80, 40),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              side: BorderSide(
                                                  width: 1,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor!)),
                                          onPressed: () {
                                            AppNavigator.navigateTo(context,
                                                AppNavigator.userDetailScreen);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.handshake,
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor,
                                                  size: 18,
                                                ),
                                                Text(
                                                  AppStrings.txtEditMyDetails
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textSelectionTheme
                                                          .selectionColor,
                                                      fontSize: 10),
                                                )
                                              ],
                                            ),
                                          )),
                                      AppDimens.shape_15,
                                      Text(
                                        AppStrings
                                            .txtStatusCreditsReactNextLevel
                                            .toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppThemeCustom
                                                .getProfileDialogTextColor(
                                                    context),
                                            fontSize: 13),
                                      ),
                                      AppDimens.shape_15,
                                      SizedBox(
                                        height: 180,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Countup(
                                                      begin: 0,
                                                      // end: (provider.getUserInfo!.pointsValue??0).toDouble(),
                                                      end: (provider.getUserInfo !=
                                                                  null &&
                                                              provider.getUserInfo!
                                                                      .statusPoints !=
                                                                  null)
                                                          ? provider
                                                              .getUserInfo!
                                                              .statusPoints!
                                                              .toDouble()
                                                          : 0,
                                                      duration: const Duration(
                                                          seconds: 1),
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .textSelectionTheme
                                                              .selectionColor,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 24)),
                                                  RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                          text:
                                                              'of ${provider.getUserInfo != null ? ((provider.getUserInfo!.statusPoints ?? 0) + (provider.getUserInfo!.requiredStatusPointsForNextTier ?? 0)) : "-"}',
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textSelectionTheme
                                                                  .selectionColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 20)),
                                                      TextSpan(
                                                          text:
                                                              '\n\nStatus credits\nfor ${provider.getUserInfo != null ? provider.getUserInfo!.nextStatusTier ?? "" : ""}'
                                                                  .toUpperCase(),
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .textSelectionTheme
                                                                  .selectionColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 8)),
                                                    ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SfRadialGauge(
                                              axes: <RadialAxis>[
                                                RadialAxis(
                                                  minimum: 0,
                                                  maximum: 100,
                                                  showLabels: false,
                                                  showTicks: false,
                                                  startAngle: 270,
                                                  endAngle: 270,
                                                  axisLineStyle: AxisLineStyle(
                                                      thickness: 0.05,
                                                      color: AppColors.white,
                                                      thicknessUnit:
                                                          GaugeSizeUnit.factor,
                                                      dashArray: const <double>[
                                                        3,
                                                        3
                                                      ]),
                                                  pointers: <GaugePointer>[
                                                    MarkerPointer(
                                                      enableAnimation: false,
                                                      value: 0,
                                                      markerWidth: 20,
                                                      markerHeight: 20,
                                                      markerType:
                                                          MarkerType.circle,
                                                      color: AppColors.white,
                                                    ),
                                                    RangePointer(
                                                      value: getCircularGraphValue(
                                                          provider.getUserInfo !=
                                                                  null
                                                              ? provider
                                                                  .getUserInfo!
                                                                  .statusPoints
                                                              : 0,
                                                          provider.getUserInfo !=
                                                                  null
                                                              ? provider
                                                                  .getUserInfo!
                                                                  .requiredStatusPointsForNextTier
                                                              : 0),
                                                      width: 0.05,
                                                      sizeUnit:
                                                          GaugeSizeUnit.factor,
                                                      cornerStyle: CornerStyle
                                                          .startCurve,
                                                      enableAnimation: true,
                                                      color: AppColors.white,
                                                    ),
                                                    MarkerPointer(
                                                      enableAnimation: true,
                                                      value: getCircularGraphValue(
                                                          provider.getUserInfo !=
                                                                  null
                                                              ? provider
                                                                  .getUserInfo!
                                                                  .statusPoints
                                                              : 0,
                                                          provider.getUserInfo !=
                                                                  null
                                                              ? provider
                                                                  .getUserInfo!
                                                                  .requiredStatusPointsForNextTier
                                                              : 0),
                                                      markerWidth: 25,
                                                      markerHeight: 25,
                                                      markerType:
                                                          MarkerType.image,
                                                      color: (provider.getUserInfo !=
                                                                  null &&
                                                              provider.getUserInfo!
                                                                      .statusPoints !=
                                                                  null)
                                                          ? AppColors.white
                                                          : Colors.transparent,
                                                      imageUrl:
                                                          'assets/common/play.png',
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      AppDimens.shape_15,
                                      Text(
                                        'HOW TO EARN STATUS CREDITS',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: AppThemeCustom
                                                .getProfileDialogTextColor(
                                                    context),
                                            fontSize: 13),
                                      ),
                                      AppDimens.shape_15,
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
                                                title: const Text(
                                                    AppStrings.txtAlert),
                                                content: const Text(AppStrings
                                                    .msgCancelAccount),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, false);
                                                      },
                                                      child: const Text(
                                                        AppStrings.txtNo,
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      )),
                                                  TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(
                                                            context, true);
                                                      },
                                                      child: Text(
                                                        AppStrings.txtYes,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
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
                                              AppStrings.txtCancelAccount
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w300,
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
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  AppStrings.txtAlert),
                                              content: const Text(
                                                  AppStrings.msgLogout),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      AppStrings.txtNo,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    )),
                                                TextButton(
                                                    onPressed: () async {
                                                      /// CLEARING ALL PREFERENCE
                                                      SharedPreferenceHelper
                                                          sharedPreferenceHelper =
                                                          await SharedPreferenceHelper
                                                              .getInstance();
                                                      sharedPreferenceHelper
                                                          .clearAll();

                                                      /// REMOVING ALL DIALOGS
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);

                                                      /// NAVIGATING TO LOGIN SCREEN
                                                      AppNavigator
                                                          .navigateReplacement(
                                                              context,
                                                              AppNavigator
                                                                  .login);
                                                    },
                                                    child: Text(
                                                      AppStrings.txtYes,
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    )),
                                              ],
                                            );
                                          });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        AppStrings.txtLogout.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300,
                                            color: AppThemeCustom
                                                .getProfileDialogTextColor(
                                                    context)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                    Theme.of(context).scaffoldBackgroundColor,
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

  double getCircularGraphValue(num? currentPoint, num? requiredPoints) {
    logEvent("Current Point --> $currentPoint Required Point --> $requiredPoints");
    if (currentPoint != null && requiredPoints != null) {
      return (currentPoint / (currentPoint + requiredPoints)) * 100;
    }
    return 0;
  }
}
