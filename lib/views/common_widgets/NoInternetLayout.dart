import 'package:flutter/material.dart';
import '../../core/utils/AppDimens.dart';
import '../../l10n/app_localizations.dart';

class NoInternetLayout extends StatelessWidget {
  const NoInternetLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off,
                size: 60,
                color: Theme.of(context).textSelectionTheme.selectionColor),
            AppDimens.shape_20,
            Text(
              AppLocalizations.of(context)!.msgNoInternet,
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textSelectionTheme.selectionColor),
            ),
          ],
        ),
      ),
    );
  }
}
