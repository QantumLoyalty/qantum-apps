import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';

class MyBenefitsScreen extends StatelessWidget {
  const MyBenefitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(AppDimens.screenPadding),
      color: Theme.of(context).buttonTheme.colorScheme!.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "VALUED",
            style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).textSelectionTheme.selectionColor),
          ),
          AppDimens.shape_20,
          Text(
            "Points for Gaming\nPoints for F & B\nPoints for Retail\nSpecial offers",

            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textSelectionTheme.selectionColor),
          ),
        ],
      ),
    );
  }
}
