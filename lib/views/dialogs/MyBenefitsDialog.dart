import 'dart:ui';

import 'package:flutter/material.dart';
import '../common_widgets/MyBenefitsWidget.dart';

class MyBenefitsDialog {
  static final MyBenefitsDialog _myBenefitsDialog =
      MyBenefitsDialog._internal();

  static MyBenefitsDialog getInstance() {
    return _myBenefitsDialog;
  }

  MyBenefitsDialog._internal();

  showBenefitsDialog(BuildContext context) {
    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, anim1, anim2) {
          return const Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            child: MyBenefitsWidget(),
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
