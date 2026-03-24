import 'dart:ui';

import 'package:flutter/material.dart';

class RenewalMembershipDialog {
  static final RenewalMembershipDialog _renewalMembershipDialog =
      RenewalMembershipDialog._instance();

  RenewalMembershipDialog._instance();

  static getInstance() {
    return _renewalMembershipDialog;
  }

  showRenewalMembershipDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, anim1, anim2) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
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
