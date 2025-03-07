import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/SpecialOffersProvider.dart';
import '../../views/common_widgets/AppLoader.dart';
import '../../views/special_offers/widgets/SpecialOfferItem.dart';
import '../../core/utils/AppDimens.dart';
import 'SpecialOfferDetailDialog.dart';

class SpecialOffersScreen extends StatefulWidget {
  const SpecialOffersScreen({super.key});

  @override
  State<SpecialOffersScreen> createState() => _SpecialOffersScreenState();
}

class _SpecialOffersScreenState extends State<SpecialOffersScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SpecialOffersProvider>(context, listen: false)
        .getSpecialOffers();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SpecialOffersProvider>(builder: (context, provider, child) {
      return Stack(
        children: [
          (provider.specialOffers != null && provider.specialOffers!.isNotEmpty)
              ? Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return SpecialOfferItem(
                        offer: provider.specialOffers![index],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return AppDimens.shape_10;
                    },
                    itemCount: provider.specialOffers!.length,
                  ),
                )
              : Container(),
          provider.showLoader != null && provider.showLoader!
              ? AppLoader()
              : Container()
        ],
      );
    });
  }
}
