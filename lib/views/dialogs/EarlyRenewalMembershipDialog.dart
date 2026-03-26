import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/core/utils/AppDateFormatter.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/core/utils/AppIcons.dart';
import 'package:qantum_apps/views/common_widgets/AppButton.dart';

import '../../l10n/app_localizations.dart';

class EarlyRenewalMembershipDialog {
  static final EarlyRenewalMembershipDialog _earlyRenewalMembershipDialog =
      EarlyRenewalMembershipDialog._instance();

  EarlyRenewalMembershipDialog._instance();

  static getInstance() {
    return _earlyRenewalMembershipDialog;
  }

  showRenewalMembershipDialog(BuildContext context) {
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
                          ),
                          AppDimens.shape_5,
                          Text(
                            "RENEWALS\nNOW OPEN",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          AppDimens.shape_15,
                          Text("Your Membership expires"),
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            color: Color(0xffD6E3F4),
                            //color: AppColors.white.withAlpha(155),
                            margin: EdgeInsets.only(top: 10),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              child: Center(child: Text(AppDateFormatter.formatDateWithSuffix(DateTime.now())??"",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                            ),
                          ),
                          Expanded(child: Container()),
                          AppButton(text: "RENEW NOW", onClick: () {}),
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
                              color: Colors.black,
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
