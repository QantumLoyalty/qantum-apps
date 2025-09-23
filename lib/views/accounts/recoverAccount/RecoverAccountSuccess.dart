import 'package:flutter/material.dart';
import '/l10n/app_localizations.dart';
import '../../../core/navigation/AppNavigator.dart';
import '../../common_widgets/AppScaffold.dart';
import '../../../core/utils/AppDimens.dart';
import '../../common_widgets/AppButton.dart';
import '../../common_widgets/AppLogo.dart';

class RecoverAccountSuccess extends StatelessWidget {
  const RecoverAccountSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations loc = AppLocalizations.of(context)!;

    return AppScaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        child: Column(
          children: [
            Applogo(
              hideTopLine: true,
            ),
            AppDimens.shape_20,
            Text(
              loc.txtSuccess,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            AppDimens.shape_5,
            Text(
              loc.msgMobileNumberUpdated,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            AppDimens.shape_30,
            AppButton(
                text: loc.txtLogin.toUpperCase(),
                onClick: () {
                  AppNavigator.navigateAndClearStack(
                      context, AppNavigator.home);
                }),
          ],
        ),
      ),
    ));
  }
}
