import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/SpecialOffersProvider.dart';
import '../../views/common_widgets/AppLoader.dart';
import '../../views/special_offers/widgets/SpecialOfferItem.dart';
import '../../core/utils/AppDimens.dart';

class SpecialOffersScreen extends StatefulWidget {
  const SpecialOffersScreen({super.key});

  @override
  State<SpecialOffersScreen> createState() => _SpecialOffersScreenState();
}

class _SpecialOffersScreenState extends State<SpecialOffersScreen> {
  late SpecialOffersProvider _specialOffersProvider;

  @override
  void initState() {
    super.initState();
    _specialOffersProvider =
        Provider.of<SpecialOffersProvider>(context, listen: false);
    _specialOffersProvider.fetchSpecialOffersTimer();
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
                  child: RefreshIndicator(
                    backgroundColor: Theme.of(context).primaryColorDark,
                    color: Theme.of(context).textSelectionTheme.selectionColor,
                    onRefresh: () async {
                      Provider.of<SpecialOffersProvider>(context, listen: false)
                          .getSpecialOffers();
                    },
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

  @override
  void dispose() {
    super.dispose();
    _specialOffersProvider.stopSpecialOffersTimer();
  }
}
