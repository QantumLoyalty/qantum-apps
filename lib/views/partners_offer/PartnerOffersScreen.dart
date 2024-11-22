import 'package:flutter/material.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';

import '../../core/utils/AppDimens.dart';

class PartnerOffersScreen extends StatelessWidget {
  const PartnerOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(AppDimens.screenPadding),
            child: InkWell(
                onTap: () {
                  AppNavigator.navigateTo(
                      context, AppNavigator.partnerOfferDetail);
                },
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)),
                  color: Colors.green,
                  child: const SizedBox(
                    height: 150,
                  ),
                ))),
      ],
    );
  }
}
