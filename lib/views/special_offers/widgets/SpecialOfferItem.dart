import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';

import '../../../core/navigation/AppNavigator.dart';
import '../../../core/utils/AppColors.dart';

class SpecialOfferItem extends StatelessWidget {
  const SpecialOfferItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: () {
          AppNavigator.navigateTo(
              context, AppNavigator.specialOfferDetailScreen);
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("\$3 Smith Chips",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                    Text(
                        "Purchase any Schooner or Pint(Pint or Imperial Pint SA) scan your Star Rewards card and get a 90g Smiths chips for only \$3",
                        style: TextStyle(color: AppColors.black, fontSize: 12))
                  ],
                ),
              ),
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
