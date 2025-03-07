import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/AppStrings.dart';
import '../../../view_models/UserInfoProvider.dart';

class PointsBalanceDialog {
  static final PointsBalanceDialog _pointsBalanceDialog =
      PointsBalanceDialog._internal();

  static PointsBalanceDialog getInstance() {
    return _pointsBalanceDialog;
  }

  PointsBalanceDialog._internal();

  showPointsBalanceDialog(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset buttonPosition = button.localToGlobal(Offset.zero);

    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            Provider.of<UserInfoProvider>(context, listen: false)
                .fetchUserPoints();
          });

          return Stack(
            children: [
              Positioned(
                left: 22,
                right: 22,
                bottom: buttonPosition.dy + 170,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      border:
                          Border.all(color: Theme.of(context).iconTheme.color!),
                      borderRadius: BorderRadius.circular(10)),
                  child: Consumer<UserInfoProvider>(
                      builder: (context, provider, child) {
                    return Column(
                      children: [
                        Text(
                          AppStrings.txtPointsBalance.toUpperCase(),
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${provider.getUserInfo!.pointsBalance} POINTS",
                          style: TextStyle(
                              fontSize: 42,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .selectionColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "\$${provider.getUserInfo!.pointsBalance}",
                          style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .primary),
                        ),
                      ],
                    );
                  }),
                ),
              )
            ],
          );
        });
  }

  dismissDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
