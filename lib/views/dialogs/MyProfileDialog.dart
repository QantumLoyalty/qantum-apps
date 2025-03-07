import 'dart:ui';

import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/flavor_config.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppHelper.dart';
import '../../core/utils/AppStrings.dart';
import '../../data/local/SharedPreferenceHelper.dart';
import '../../view_models/UserInfoProvider.dart';
import '../common_widgets/IconTextWidget.dart';

class MyProfileDialog {
  static final MyProfileDialog _myProfileDialog = MyProfileDialog._internal();

  static MyProfileDialog getInstance() {
    return _myProfileDialog;
  }

  MyProfileDialog._internal();

  showMyProfileDialog(BuildContext context) async {
    SharedPreferenceHelper sharedPreferenceHelper =
        await SharedPreferenceHelper.getInstance();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();



    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, anim1, anim2) {


          print(FlavorConfig.instance.flavorValues.appVersion);


          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: Center(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.90,
                  //  padding: EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.90 - 80,
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
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        size: 40,
                                      ),
                                      Text(
                                        "${provider.getUserInfo!.firstName} ${provider.getUserInfo!.lastName}",
                                        style: TextStyle(
                                            fontSize: 28,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor),
                                      ),
                                      Text(
                                        "Card # ${provider.getUserInfo!.cardNumber}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .buttonTheme
                                                .colorScheme!
                                                .primary),
                                      ),
                                      AppDimens.shape_20,
                                      IconTextWidget(
                                        orientation: IconTextWidget.HORIZONTAL,
                                        icon: Icons.cake,
                                        iconSize: 18,
                                        text: AppHelper.formatDate(
                                            provider.getUserInfo!.dateOfBirth),
                                        iconColor: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        textColor: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                      ),
                                      IconTextWidget(
                                        orientation: IconTextWidget.HORIZONTAL,
                                        icon: Icons.phone_android_outlined,
                                        iconSize: 18,
                                        text: "${provider.getUserInfo!.mobile}",
                                        iconColor: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        textColor: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                      ),
                                      IconTextWidget(
                                        orientation: IconTextWidget.HORIZONTAL,
                                        icon: Icons.email_outlined,
                                        iconSize: 18,
                                        text: "${provider.getUserInfo!.email}",
                                        iconColor: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
                                        textColor: Theme.of(context)
                                            .textSelectionTheme
                                            .selectionColor,
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
                                                      .buttonTheme
                                                      .colorScheme!
                                                      .primary)),
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
                                                      .buttonTheme
                                                      .colorScheme!
                                                      .primary,
                                                  size: 18,
                                                ),
                                                Text(
                                                  AppStrings.txtEditMyDetails
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .buttonTheme
                                                          .colorScheme!
                                                          .primary,
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
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
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
                                        'How to earn Status Credits',
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
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
                                                          AppStrings.txtNo)),
                                                  TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(
                                                            context, true);
                                                      },
                                                      child: const Text(
                                                          AppStrings.txtYes)),
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
                                                  color: Theme.of(context)
                                                      .textSelectionTheme
                                                      .selectionColor),
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
                                                        AppStrings.txtNo)),
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
                                                    child: const Text(
                                                        AppStrings.txtYes)),
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
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor),
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
                              Text(
                                "V 1.0.0",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor),
                              ),
                              CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).primaryColorDark,
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
    AppHelper.printMessage(
        "Current Point --> $currentPoint Required Point --> $requiredPoints");
    if (currentPoint != null && requiredPoints != null) {
      return (currentPoint / (currentPoint + requiredPoints)) * 100;
    }
    return 0;
  }
}
