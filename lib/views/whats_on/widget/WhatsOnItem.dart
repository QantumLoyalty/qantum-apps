import 'package:flutter/material.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';

import '../../../core/utils/AppColors.dart';
import '../../../core/utils/AppDimens.dart';
import '../../../core/utils/AppStrings.dart';

class WhatsOnItem extends StatelessWidget {
  const WhatsOnItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: () {
          AppNavigator.navigateTo(context, AppNavigator.whatsOnDetailScreen);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                size: 80,
                color: AppColors.black,
              ),
              AppDimens.shape_5,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "${AppStrings.txtEntries}: ",
                            style: TextStyle(
                                color: AppColors.black, fontSize: 14)),
                        TextSpan(
                            text: "0",
                            style: TextStyle(
                                color: AppColors.black, fontSize: 24)),
                      ])),
                  Text("Your chance to win 1 of 150 Kayo Sports Subscriptions",
                      style: TextStyle(color: AppColors.black, fontSize: 12))
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).dividerColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
