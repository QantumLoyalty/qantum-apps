import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppColors.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../core/navigation/AppNavigator.dart';

class SpecialOfferDetailScreen extends StatelessWidget {
  const SpecialOfferDetailScreen({super.key});

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
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Card(
                color: AppColors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.image,
                        size: 70,
                        color: AppColors.black,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\$3 Smith Chips",
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          Text(
                              "Purchase any Schooner or Pint(Pint or Imperial Pint SA) scan your Star Rewards card and get a 90g Smiths chips for only \$3",
                              style: TextStyle(
                                  color: AppColors.black.withOpacity(0.9),
                                  fontSize: 12))
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: (MediaQuery.of(context).size.height * 0.3) / 1.5,
                left: 20,
                right: 20,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        AppDimens.shape_20,
                        Text("\$3 Smith Chips",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                        AppDimens.shape_20,
                        QrImageView(
                          data: '1234567890',
                          size: 120,
                          version: QrVersions.auto,
                        ),
                        AppDimens.shape_20,
                        Text("Valid 30 Sept 2024 - 31 Dec 2024",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                        AppDimens.shape_20,
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
