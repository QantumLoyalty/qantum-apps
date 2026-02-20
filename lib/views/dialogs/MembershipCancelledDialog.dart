import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/app_theme_custom.dart';
import 'package:qantum_apps/core/utils/FlavorConstants.dart';
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
    AppLocalizations loc = AppLocalizations.of(context)!;
    final media = MediaQuery.of(context).size;
    final dialogHeight = media.height * 0.5;

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
                              width: media.width,
                              height: dialogHeight - 30,
                              child: Consumer<UserInfoProvider>(
                                  builder: (context, provider, child) {
                                return Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                AppIcons.getCardBackground(
                                                    FlavorConstants
                                                        .getUserTierType(
                                                            provider
                                                                .getUserInfo!)),
                                              ))),
                                      child: Container(
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
                                      )
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
                                          FlavorConstants.getUserTierType(
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
}
