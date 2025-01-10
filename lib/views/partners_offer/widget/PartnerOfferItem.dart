import 'package:flutter/material.dart';

import '../../dialogs/PartnerOfferDialog.dart';

class PartnerOfferItem extends StatelessWidget {
  const PartnerOfferItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {

            PartnerOfferDialog.getInstance().showPartnerOfferDialog(context);
          },
          child: Image.asset(
            'assets/common/partner_offer_placeholder.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
