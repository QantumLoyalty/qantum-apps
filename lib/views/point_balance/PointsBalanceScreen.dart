import 'package:flutter/material.dart';

import '../../core/utils/AppDimens.dart';

class PointsBalanceScreen extends StatelessWidget {
  const PointsBalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(AppDimens.screenPadding),
      color: Theme.of(context).buttonTheme.colorScheme!.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "\$0.00",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).textSelectionTheme.selectionColor),
          ),
          AppDimens.shape_10,
          Text(
            "0 Points",
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
