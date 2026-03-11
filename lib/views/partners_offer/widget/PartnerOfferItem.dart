import 'package:flutter/material.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';

import '../../dialogs/PartnerOfferDialog.dart';

class PartnerOfferItem extends StatelessWidget {
  String imagePath;

  PartnerOfferItem({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(8), ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () {
      AppNavigator.navigateTo(context, AppNavigator.unitedFuelMainScreen);
          },
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 110,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                width: double.infinity,
                height: 110,
                child: const Icon(Icons.image_not_supported,size: 72,),
              );
            },
          ),
        ),
      ),
    );
  }
}
