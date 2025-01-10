import 'package:flutter/material.dart';
import 'package:qantum_apps/views/special_offers/widgets/SpecialOfferItem.dart';

import '../../core/utils/AppDimens.dart';

class SpecialOffersScreen extends StatelessWidget {
  const SpecialOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return const SpecialOfferItem();
        },
        separatorBuilder: (BuildContext context, int index) {
          return AppDimens.shape_10;
        },
        itemCount: 10,
      ),
    );
  }
}
