import 'package:flutter/material.dart';

import '/views/partners_offer/widget/PartnerOfferItem.dart';
import '../../core/utils/AppDimens.dart';

class PartnerOffersScreen extends StatefulWidget {
  const PartnerOffersScreen({super.key});

  @override
  State<PartnerOffersScreen> createState() => _PartnerOffersScreenState();
}

class _PartnerOffersScreenState extends State<PartnerOffersScreen> {
  List<String> offersList = [
    "assets/common/partner_offer_placeholder.png",
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
