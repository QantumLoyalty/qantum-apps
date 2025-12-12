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

class MembershipCancelledDialog {
  static final MembershipCancelledDialog _digitalCardDialog =
      MembershipCancelledDialog._internal();

  static MembershipCancelledDialog getInstance() {
    return _digitalCardDialog;
  }

  MembershipCancelledDialog._internal();

  showMembershipCancelledDialog(BuildContext context) async {
    SharedPreferenceHelper sharedPreferenceHelper =
        await SharedPreferenceHelper.getInstance();
    UserModel? userData = await sharedPreferenceHelper.getUserData();
    String userTierType = await AppHelper.getUserTierType(userData!);
    AppLocalizations loc = AppLocalizations.of(context)!;
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
                height: MediaQuery.of(context).size.height * 0.5,
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
                                  MediaQuery.of(context).size.height * 0.5 - 30,
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
                                          const Icon(
                                            Icons.cancel_outlined,
                                            size: 70,
                                            color: Colors.black,
                                          ),
                                          AppDimens.shape_20,
                                          SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Text(
                                                  loc.membership_unavailable_title,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      height: 1.2,
                                                      fontSize: 32,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                AppDimens.shape_20,
                                                Text(
                                                  loc.contact_to_venue_text,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: 15),
                                                ),
                                                AppDimens.shape_20,
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
                                bottom: 0,
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
                                        color: Colors.black,
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
    };

    return _scanCodes[FlavorConfig.instance.flavor] ?? "ABC1234";

    // Flavor flavor = FlavorConfig.instance.flavor!;
    /* if (flavor == Flavor.mhbc) {
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
      return "BBCAAAAAA";
    } else if (flavor == Flavor.woollahra) {
      return "WHT";
    } else if (flavor == Flavor.flinders) {
      return "FSW";
    } else if (flavor == Flavor.bluewater) {
      return "BBGAAAAAA";
    } else {
      return "ABC1234";
    }*/
  }
}
