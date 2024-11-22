import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';

import '../../core/navigation/AppNavigator.dart';

class WhatsOnDetailScreen extends StatelessWidget {
  const WhatsOnDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              AppNavigator.goBack(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        child: Column(
          children: [
            Card(
              color: Colors.blue,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
            ),
            AppDimens.shape_10,
            Expanded(
                child: SingleChildScrollView(
                    child: Text(
              'Win BIG with Hahn!\n\nGet ready for non-stop sports action with a 12-month\nKayo Sports subscription!\n\nPurchase any Hahn product and scan your Star\nRewards to enter for a chance to win.\n\nThere are 5 subscriptions up for grabs EVERY DAY!\n\nDon\'t miss out - entries close 18th November!\n\nTime to grab a Hahn, cheers to the game, and may\nthe odds be ever in your favour!\n\nT&C\'s Apply',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.w500),
            )))
          ],
        ),
      ),
    );
  }
}
