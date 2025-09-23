import 'package:flutter/material.dart';
import '/core/navigation/AppNavigator.dart';
import '/core/utils/AppColors.dart';
import '/core/utils/AppDimens.dart';

class PromotionDetailScreen extends StatelessWidget {
  const PromotionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        color: AppColors.white,
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        child: Column(
          children: [
            Card(
              color: Colors.blue,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
            ),
            AppDimens.shape_20,
            Expanded(
              child: Center(
                child: Text(
                  "Win a Carton of Wayward!\n\nWe've got 10 prizes up for grabs, each with 5 cartons of Wayward!\n\nJust purchase any Wayward product this November and scan your Star Rewards to enter.\n\nEntries close November 30th-get in quick for your chance to stock up!\n\nT&Cs apply.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.black,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
