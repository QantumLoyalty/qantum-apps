import 'package:flutter/material.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';
import 'package:qantum_apps/views/partners_offer/widget/PartnerOfferItem.dart';

import '../../core/utils/AppDimens.dart';

class PartnerOffersScreen extends StatelessWidget {
  const PartnerOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return const PartnerOfferItem();
        },
        separatorBuilder: (BuildContext context, int index) {
          return AppDimens.shape_10;
        },
        itemCount: 10,
      ),
    );
  }
}
