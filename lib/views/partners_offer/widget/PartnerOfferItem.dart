import 'package:flutter/material.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';

import '../../dialogs/PartnerOfferDialog.dart';

class PartnerOfferItem extends StatelessWidget {
  String imagePath;

  PartnerOfferItem({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
      /*      PartnerOfferDialog.getInstance()
                .showPartnerOfferDialog(context, imagePath);
      */
      AppNavigator.navigateTo(context, AppNavigator.unitedFuelMainScreen);
          },
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
