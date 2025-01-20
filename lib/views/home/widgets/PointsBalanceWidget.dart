import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/AppStrings.dart';
import '../../../view_models/UserInfoProvider.dart';

class PointsBalanceWidget extends StatefulWidget {
  const PointsBalanceWidget({super.key});

  @override
  State<PointsBalanceWidget> createState() => _PointsBalanceWidgetState();
}

class _PointsBalanceWidgetState extends State<PointsBalanceWidget> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserInfoProvider>(context, listen: false).fetchUserPoints();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            border: Border.all(color: Theme.of(context).iconTheme.color!),
            borderRadius: BorderRadius.circular(10)),
        child: Consumer<UserInfoProvider>(builder: (context, provider, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.txtPointsBalance.toUpperCase(),
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "\$${(provider.getUserInfo!.pointsBalance ?? 0).toStringAsFixed(2)}",
                style: TextStyle(
                    fontSize: 42,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "${(provider.getUserInfo!.pointsValue ?? 0)} POINTS",
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).buttonTheme.colorScheme!.primary),
              ),
            ],
          );
        }),
      ),
    );
  }
}
