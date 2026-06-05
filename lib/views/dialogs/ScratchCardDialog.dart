import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_scratch_card/flutter_scratch_card.dart';
import 'package:qantum_apps/core/extensions/log_extension.dart';
import 'package:qantum_apps/data/models/incentives/SmartIncentivesResponse.dart';

import '../../core/extensions/spacer_extension.dart';
import '../../l10n/app_localizations.dart';
import '../common_widgets/MetallicGradientText.dart';
import '../common_widgets/ScratchAndWinWidget.dart';
import '/core/utils/AppColors.dart';
import '/core/utils/AppDimens.dart';

class ScratchCardDialog {
  static final ScratchCardDialog _instance = ScratchCardDialog._internal();

  ScratchCardDialog._internal();

  static ScratchCardDialog getInstance() {
    return _instance;
  }

  showScratchCardDialog(BuildContext context,
      {required MatchedIncentive incentive}) {
    showGeneralDialog(
        context: context,
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, anim1, anim2) {
          return Dialog(
            backgroundColor: Theme.of(context).primaryColor,
            insetPadding: EdgeInsets.zero,
            child: ScratchAndWinWidget(
              incentive: incentive,
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
