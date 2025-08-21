import 'package:flutter/material.dart';

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
            PartnerOfferDialog.getInstance()
                .showPartnerOfferDialog(context, imagePath);
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
