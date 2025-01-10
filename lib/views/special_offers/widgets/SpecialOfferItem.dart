import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppDimens.dart';
import 'package:qantum_apps/core/utils/AppIcons.dart';

import '../../../core/navigation/AppNavigator.dart';
import '../../../core/utils/AppColors.dart';
import '../SpecialOfferDetailDialog.dart';

class SpecialOfferItem extends StatelessWidget {
  const SpecialOfferItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: InkWell(
        onTap: () {
          SpecialOfferDetailDialog.getInstance()
              .showSpecialOfferDialog(context);
        },
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 10,
              top: 0,
              bottom: 0,
              child: Card(
                color: AppColors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      child: AspectRatio(
                        aspectRatio: 1.2,
                        child: Image.asset(
                          'assets/common/special_offers_placeholder.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    AppDimens.shape_10,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Brewdog Punk XPA 4pk \$14",
                                maxLines: 1,
                                style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                            Text(
                                "Present this voucher to receive a 4 pack of Brewdog Punk XPA for \$14",
                                maxLines: 2,
                                style: TextStyle(
                                    color: AppColors.black, fontSize: 11)),
                            AppDimens.shape_5,
                            Text(
                              'valid till 12.1.25',
                              style: TextStyle(
                                  fontSize: 8,
                                  color: AppColors.bright_sky_blue),
                            )
                          ],
                        ),
                      ),
                    ),
                    AppDimens.shape_15,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.white,
                child: Icon(
                  Icons.chevron_right,
                  size: 25,
                  color: AppColors.bright_sky_blue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
