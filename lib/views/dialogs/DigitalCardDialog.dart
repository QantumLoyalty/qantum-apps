import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/app_theme_custom.dart';
import '../../l10n/app_localizations.dart';
import '/core/flavors_config/flavor_config.dart';
import '../../core/utils/AppHelper.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppIcons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:secure_content/secure_content.dart';
import '../../core/utils/AppColors.dart';
import '../../data/local/SharedPreferenceHelper.dart';
import '../../data/models/UserModel.dart';
import '../../view_models/UserInfoProvider.dart';

class DigitalCardDialog {
  static final DigitalCardDialog _digitalCardDialog =
      DigitalCardDialog._internal();

  static DigitalCardDialog getInstance() {
    return _digitalCardDialog;
  }

  DigitalCardDialog._internal();

  showDigitalCardDialog(BuildContext context) async {
    SharedPreferenceHelper sharedPreferenceHelper =
        await SharedPreferenceHelper.getInstance();
    UserModel? userData = await sharedPreferenceHelper.getUserData();
    String userTierType = await AppHelper.getUserTierType(userData!);

    await showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, anim1, anim2) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Consumer<UserInfoProvider>(
                    builder: (context, provider, child) {
                  return SecureWidget(
                      isSecure: true,
                      builder: (context, onInit, onDispose) {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              margin:
                                  const EdgeInsets.only(left: 25, right: 25),
                              width: MediaQuery.of(context).size.width,
                              height:
                                  MediaQuery.of(context).size.height * 0.7 - 80,
                              child: Consumer<UserInfoProvider>(
                                  builder: (context, provider, child) {
                                return Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.asset(
                                        AppIcons.getCardBackground(
                                            AppHelper.getUserTierType(
                                                provider.getUserInfo!)),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          AppDimens.shape_20,
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: QrImageView(
                                              data:
                                                  '${getScancode()}${provider.getUserInfo!.cardNumber}',
                                              backgroundColor: AppColors.white,
                                              size: 180,
                                            ),
                                          ),
                                          AppDimens.shape_20,
                                          SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  userTierType.toUpperCase(),
                                                  style: TextStyle(
                                                      /* shadows: [
                                                        Shadow(
                                                          offset: const Offset(
                                                              1.0, 1.0),
                                                          blurRadius: 3.0,
                                                          color: AppColors.black
                                                              .withValues(
                                                                  alpha: 0.5),
                                                        )
                                                      ],*/
                                                      color: AppThemeCustom
                                                          .getCardDialogsTextColor(
                                                              context),
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .txtMembership,
                                                  style: TextStyle(
                                                      /*shadows: [
                                                        Shadow(
                                                          offset: const Offset(
                                                              1.0, 1.0),
                                                          blurRadius: 3.0,
                                                          color: AppColors.black
                                                              .withValues(
                                                                  alpha: 0.5),
                                                        )
                                                      ],*/
                                                      color: AppThemeCustom
                                                          .getCardDialogsTextColor(
                                                              context),
                                                      fontSize: 18),
                                                ),
                                                AppDimens.shape_20,
                                                Text(
                                                  "${AppLocalizations.of(context)!.txtTime}: ${DateFormat("HH:mm").format(DateTime.now())}\n${AppLocalizations.of(context)!.txtDate}: ${DateFormat("dd MMMM yyyy").format(DateTime.now())}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      /*shadows: [
                                                        Shadow(
                                                          offset: const Offset(
                                                              1.0, 1.0),
                                                          blurRadius: 3.0,
                                                          color: AppColors.black
                                                              .withValues(
                                                                  alpha: 0.5),
                                                        )
                                                      ],*/
                                                      color: AppThemeCustom
                                                          .getCardDialogsTextColor(
                                                              context),
                                                      fontSize: 14),
                                                ),
                                                (showMembershipCategory(userData
                                                        .membershipCategory))
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          AppDimens.shape_30,
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .txtMembership,
                                                            style: TextStyle(
                                                                /*shadows: [
                                                                  Shadow(
                                                                    offset:
                                                                        const Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        3.0,
                                                                    color: AppColors
                                                                        .black
                                                                        .withValues(
                                                                            alpha:
                                                                                0.5),
                                                                  )
                                                                ],*/
                                                                color: AppThemeCustom
                                                                    .getCardDialogsTextColor(
                                                                        context),
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            "${userData.membershipCategory}",
                                                            style: TextStyle(
                                                                /*shadows: [
                                                                  Shadow(
                                                                    offset:
                                                                        const Offset(
                                                                            1.0,
                                                                            1.0),
                                                                    blurRadius:
                                                                        3.0,
                                                                    color: AppColors
                                                                        .black
                                                                        .withValues(
                                                                            alpha:
                                                                                0.5),
                                                                  )
                                                                ],*/
                                                                color: AppThemeCustom
                                                                    .getCardDialogsTextColor(
                                                                        context),
                                                                fontSize: 22),
                                                          ),
                                                        ],
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            Positioned(
                                left: 0,
                                right: 0,
                                bottom: 50,
                                child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  backgroundImage: ExactAssetImage(
                                      AppIcons.getCardBackground(
                                          AppHelper.getUserTierType(
                                              provider.getUserInfo!))),
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
                                ))
                          ],
                        );
                      });
                }),
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

  bool showMembershipCategory(String? membershipCategory) {
    Flavor flavor = FlavorConfig.instance.flavor!;
    if (flavor == Flavor.mhbc) {
      if (membershipCategory != null && membershipCategory.isNotEmpty) {
        switch (membershipCategory.toUpperCase()) {
          case "NON FINANCIAL":
            return true;
          case "INVITE ONLY":
            return true;
          case "STAFF":
            return true;
          default:
            return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  String getScancode() {
    Flavor flavor = FlavorConfig.instance.flavor!;

    if (flavor == Flavor.mhbc) {
      return "MHBCAAAAA";
    } else if (flavor == Flavor.clh) {
      return "CLH";
    } else if (flavor == Flavor.northShoreTavern) {
      return "NST";
    } else if (flavor == Flavor.montaukTavern) {
      return "MTT";
    } else if (flavor == Flavor.hogansReward) {
      return "HWP";
    } else if (flavor == Flavor.starReward) {
      return "SHG";
    } else if (flavor == Flavor.aceRewards) {
      return "WML";
    } else if (flavor == Flavor.queens) {
      return "QHG";
    } else if (flavor == Flavor.brisbane) {
      return "BBC";
    } else if (flavor == Flavor.woollahra) {
      return "WHT";
    } else if (flavor == Flavor.bluewater) {
      return "BBGAAAAAA";
    } else {
      return "ABC1234";
    }
  }
}
