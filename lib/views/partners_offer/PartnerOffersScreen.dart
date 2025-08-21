import 'package:flutter/material.dart';
import '/views/partners_offer/widget/PartnerOfferItem.dart';

import '../../core/utils/AppDimens.dart';

class PartnerOffersScreen extends StatelessWidget {
  PartnerOffersScreen({super.key});

  List<String> offersList = [
    "assets/common/partner_offer_placeholder.png",
    "assets/common/partner_offer_placeholder_2.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return PartnerOfferItem(
            imagePath: offersList[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return AppDimens.shape_10;
        },
        itemCount: offersList.length,
      ),
    );
  }
}
