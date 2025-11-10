import 'package:flutter/material.dart';
import '/views/common_widgets/AppButton.dart';
import '../../core/navigation/AppNavigator.dart';
import '/views/common_widgets/AppScaffold.dart';
import '../../core/utils/AppDimens.dart';
import '../../l10n/app_localizations.dart';
import '../common_widgets/AppLogo.dart';
import 'widgets/BottomInfoWidget.dart';

class ReceptionPaymentScreen extends StatelessWidget {
  late AppLocalizations loc;

  ReceptionPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(AppDimens.screenPadding),
      child: Column(
        children: [
          Applogo(),
          AppDimens.shape_30,
          Text(
            loc.payAtReception,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          AppDimens.shape_30,
          Text(
            loc.receptionPaymentMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textSelectionTheme.selectionColor,
            ),
          ),
          Expanded(child: Container()),
          AppButton(
            text: loc.txtOk.toUpperCase(),
            onClick: () {
              AppNavigator.navigateTo(
                  context, AppNavigator.pendingPaymentScreen);
            },
          ),
          AppDimens.shape_10,
          BottomInfoWidget(
            message: loc.membershipRequiresApproval,
          )
        ],
      ),
    )));
  }
}
