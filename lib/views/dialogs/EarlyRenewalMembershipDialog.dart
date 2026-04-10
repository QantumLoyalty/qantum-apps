import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/app_theme_custom.dart';
import 'package:qantum_apps/data/models/MembershipModel.dart';
import 'package:qantum_apps/view_models/UserInfoProvider.dart';
import 'package:qantum_apps/views/common_widgets/AppCustomButton.dart';

import '/core/navigation/AppNavigator.dart';
import '/core/utils/AppDateFormatter.dart';
import '/core/utils/AppDimens.dart';
import '/core/utils/AppIcons.dart';
import '../../core/utils/AppColors.dart';
import '../../l10n/app_localizations.dart';
import '../../view_models/MembershipManagerProvider.dart';

class EarlyRenewalMembershipDialog {
  static final EarlyRenewalMembershipDialog _earlyRenewalMembershipDialog =
      EarlyRenewalMembershipDialog._instance();

  EarlyRenewalMembershipDialog._instance();

  static getInstance() {
    return _earlyRenewalMembershipDialog;
  }

  showRenewalMembershipDialog(
      {required BuildContext context,
      required MembershipModel currentMembership}) {
    AppLocalizations loc = AppLocalizations.of(context)!;
    final media = MediaQuery.of(context).size;
    final dialogHeight = media.height * 0.5;

    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, anim1, anim2) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: SizedBox(
              width: double.infinity,
              height: dialogHeight,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    child: Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 25, bottom: 30),
                      width: media.width,
                      height: dialogHeight - 30,
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            AppIcons.renew,
                            width: 24,
                            height: 24,
                            color: AppThemeCustom.getEarlyBirdDialogTextColor(
                                context),
                          ),
                          AppDimens.shape_5,
                          Text(
                            loc.renewalOpen,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppThemeCustom.getEarlyBirdDialogTextColor(
                                  context),
                            ),
                          ),
                          AppDimens.shape_15,
                          Text(loc.yourMembershipExpires,
                              style: TextStyle(
                                color:
                                    AppThemeCustom.getEarlyBirdDialogTextColor(
                                        context),
                              )),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                            //  color: const Color(0xffD6E3F4),
                            color: AppColors.white.withAlpha(155),
                            margin: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(15),
                              child: Center(child: Consumer<UserInfoProvider>(
                                  builder: (context, provider, child) {
                                return Text(
                                  AppDateFormatter.formatDateWithSuffix(
                                          DateFormat("yyyy-MM-ddThh:mm:ss.000Z")
                                              .parse(provider.getUserInfo!
                                                  .membershipExpiryDate!)) ??
                                      "",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: AppThemeCustom
                                        .getEarlyBirdDialogTextColor(context),
                                  ),
                                );
                              })),
                            ),
                          ),
                          Expanded(child: Container()),
                          AppCustomButton(
                              text: loc.renewNow,
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      AppThemeCustom.getEarlyBirdButtonColor(
                                          context))),
                              onClick: () {
                                Navigator.pop(context);
                                context
                                    .read<MembershipManagerProvider>()
                                    .updateDropdownValue(currentMembership);
                                /*Map<String, String> params = {};
                                params['membershipFlowSource'] =
                                    MembershipFlowSource.earlyBird.name;*/
                                AppNavigator.navigateTo(
                                    context,
                                    AppNavigator
                                        .earlyBirdRenewalMembershipScreen);
                              }),
                          //AppDimens.shape_30
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
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
                      ))
                ],
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
