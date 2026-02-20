import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/app_theme_custom.dart';
import 'package:qantum_apps/core/mixins/logging_mixin.dart';
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

class DigitalCardDialog with LoggingMixin {
  static final DigitalCardDialog _digitalCardDialog =
      DigitalCardDialog._internal();

  static DigitalCardDialog getInstance() {
    return _digitalCardDialog;
  }

  DigitalCardDialog._internal();

  showDigitalCardDialog(BuildContext context) async {
    UserModel? userData = context.read<UserInfoProvider>().getUserInfo;

    if (userData == null) return;

    String userTierType = AppHelper.getUserTierType(userData);
    final media = MediaQuery.of(context);
    final dialogHeight = media.size.height * 0.7;
    const textShadows = [
      Shadow(
        offset: Offset(1.0, 1.0),
        blurRadius: 3.0,
        color: Color(0x80000000),
      )
    ];

    final cardBackground = AppIcons.getCardBackground(userTierType);

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
                height: dialogHeight,
                child: SecureWidget(
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
                            width: media.size.width,
                            height: dialogHeight - 80,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(cardBackground),
                                          fit: BoxFit.fill)),
                                ),
                                Consumer<UserInfoProvider>(builder: (context,provider,child){return Container(
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
                                                  shadows: textShadows,
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
                                                  shadows: textShadows,
                                                  color: AppThemeCustom
                                                      .getCardDialogsTextColor(
                                                      context),
                                                  fontSize: 18),
                                            ),
                                            AppDimens.shape_5,
                                            (showMembershipCategory(userData
                                                .membershipCategory))
                                                ? Column(
                                              children: [
                                                Text(
                                                  "${userData.membershipCategory}",
                                                  style: TextStyle(
                                                      shadows:
                                                      textShadows,
                                                      color: AppThemeCustom
                                                          .getCardDialogsTextColor(
                                                          context),
                                                      fontSize: 16),
                                                ),
                                                AppDimens.shape_5,
                                                Text(
                                                    '#${userData.bluizeId}',
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                        color: AppThemeCustom
                                                            .getCardDialogsTextColor(
                                                            context),
                                                        fontSize: 14))
                                              ],
                                            )
                                                : const SizedBox.shrink(),
                                            AppDimens.shape_20,
                                            Text(
                                              "${AppLocalizations.of(context)!.txtTime}: ${DateFormat("HH:mm").format(DateTime.now())}\n${AppLocalizations.of(context)!.txtDate}: ${DateFormat("dd MMMM yyyy").format(DateTime.now())}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  shadows: textShadows,
                                                  color: AppThemeCustom
                                                      .getCardDialogsTextColor(
                                                      context),
                                                  fontSize: 14),
                                            ),
                                            ((userMembershipExpiry(userData
                                                .membershipExpiryDate)) !=
                                                null &&
                                                (userMembershipExpiry(userData
                                                    .membershipExpiryDate))!
                                                    .isNotEmpty)
                                                ? Padding(
                                              padding:
                                              const EdgeInsets.only(
                                                  top: 12),
                                              child: Text(
                                                "Membership Expiry: ${(userMembershipExpiry(userData.membershipExpiryDate))}",
                                                style: TextStyle(
                                                    shadows:
                                                    textShadows,
                                                    color: AppThemeCustom
                                                        .getCardDialogsTextColor(
                                                        context),
                                                    fontSize: 14),
                                              ),
                                            )
                                                : const SizedBox.shrink(),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );}),
                              ],
                            ),
                          ),
                          Positioned(
                              left: 0,
                              right: 0,
                              bottom: 50,
                              child: CircleAvatar(
                                backgroundColor:
                                Theme.of(context).primaryColor,
                                backgroundImage: ExactAssetImage(cardBackground),
                                radius: 30,

                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    tooltip:"close",
                                    icon: Icon(
                                      Icons.clear,
                                      size: 30,
                                      color: Colors.white,
                                      shadows: <Shadow>[
                                        Shadow(
                                            color: AppColors.black
                                                .withValues(alpha: 0.5),
                                            offset: const Offset(1.0, 1.0),
                                            blurRadius: 3.0)
                                      ],
                                    )),
                              ))
                        ],
                      );
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
    const hiddenCategories = {
      "NON FINANCIAL",
      "INVITE ONLY",
      "STAFF",
    };
    if (flavor != Flavor.mhbc ||
        membershipCategory == null ||
        membershipCategory.isEmpty) {
      return false;
    }

    return !hiddenCategories.contains(membershipCategory.toUpperCase());
  }

  String? userMembershipExpiry(String? membershipExpiry) {
    Flavor flavor = FlavorConfig.instance.flavor!;

    if (flavor == Flavor.mhbc) {
      if (membershipExpiry == null || membershipExpiry.isEmpty) return null;

      try {
        DateFormat dateTimeFormat = DateFormat("yyyy-MM-ddThh:mm:ss.000Z");
        DateFormat newDateTimeFormat = DateFormat("dd MMM, yyyy");
        return newDateTimeFormat
            .format((dateTimeFormat.parse(membershipExpiry)));
      } catch (e) {
        logEvent(e.toString());
        return null;
      }
    } else {
      return null;
    }
  }

  String getScancode() {
    const Map<Flavor, String> _scanCodes = {
      Flavor.mhbc: "MHBCAAAAA",
      Flavor.clh: "CLH",
      Flavor.northShoreTavern: "NST",
      Flavor.montaukTavern: "MTT",
      Flavor.hogansReward: "HWP",
      Flavor.starReward: "SHG",
      Flavor.aceRewards: "WML",
      Flavor.queens: "QHG",
      Flavor.brisbane: "BBCAAAAAA",
      Flavor.woollahra: "WHT",
      Flavor.flinders: "FSW",
      Flavor.bluewater: "BBGAAAAAA",
      Flavor.kingscliff: "KBH",
      Flavor.drinkRewards: "DHQ",
    };

    return _scanCodes[FlavorConfig.instance.flavor] ?? "ABC1234";
  }
}
