import 'package:flutter/material.dart';

import '../../core/flavors_config/flavor_config.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../l10n/app_localizations.dart';
import '../common_widgets/AppButton.dart';
import '../common_widgets/AppLogo.dart';
import '../common_widgets/AppScaffold.dart';

class WelcomeScreen extends StatelessWidget {
  late AppLocalizations loc;
  late Flavor flavor;

  WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    flavor = FlavorConfig.instance.flavor!;
    return AppScaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Applogo(
              iconPadding: 30.0,
              customIconHeight: 150.0,
              customIconWidth: 180.0,
            ),
            Text(
              loc.txtWelcome,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            Text(
              loc.registerToContinue,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
            AppDimens.shape_20,
            AppButton(
              text: loc.register.toUpperCase(),
              onClick: () {

                   AppNavigator.navigateAndClearStack(context, AppNavigator.login,
                    arguments: true);
              },
            ),
            AppDimens.shape_30,
            InkWell(
              onTap: () {
                AppNavigator.navigateAndClearStack(context, AppNavigator.login);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: loc.alreadyHaveAnAccount,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                        )),
                    TextSpan(
                        text: " ${loc.txtLogin}",
                        style: TextStyle(
                            fontSize: 13,
                            color: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            fontWeight: FontWeight.bold))
                  ]),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
