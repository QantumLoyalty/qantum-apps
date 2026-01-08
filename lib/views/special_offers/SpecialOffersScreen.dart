import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/flavors_config/flavor_config.dart';
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
  final _filter = ["All", "WMLC", "Fielders"];
  final _filterSR = ["ALL", "HOTEL", "BOTTLE SHOP"];
  late Flavor selectedFlavor;

  @override
  void initState() {
    super.initState();
    _specialOffersProvider =
        Provider.of<SpecialOffersProvider>(context, listen: false);
   // _specialOffersProvider.getSpecialOffersFilters();
     _specialOffersProvider.fetchSpecialOffersTimer();
    selectedFlavor = FlavorConfig.instance.flavor!;
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
                  child: Column(
                    children: [
                      (selectedFlavor == Flavor.aceRewards ||
                              selectedFlavor == Flavor.starReward)
                          ? SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColorDark,
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .buttonTheme
                                              .colorScheme!
                                              .onSecondary),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      selectedFlavor == Flavor.aceRewards
                                          ? _filter[index]
                                          : _filterSR[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                          ),
                                    ),
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: selectedFlavor == Flavor.aceRewards
                                    ? _filter.length
                                    : _filterSR.length,
                              ),
                            )
                          : Container(),
                      Expanded(
                        child: RefreshIndicator(
                          backgroundColor: Theme.of(context).primaryColorDark,
                          color: Theme.of(context)
                              .textSelectionTheme
                              .selectionColor,
                          onRefresh: () async {
                            Provider.of<SpecialOffersProvider>(context,
                                    listen: false)
                                .getSpecialOffers();
                          },
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return SpecialOfferItem(
                                offer: provider.specialOffers![index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return AppDimens.shape_10;
                            },
                            itemCount: provider.specialOffers!.length,
                          ),
                        ),
                      ),
                    ],
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
