import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/l10n/app_localizations.dart';
import 'package:qantum_apps/view_models/InternetStatusProvider.dart';
import '../../core/flavors_config/flavor_config.dart';
import '../../view_models/SpecialOffersProvider.dart';
import '../../views/common_widgets/AppLoader.dart';
import '../../views/special_offers/widgets/SpecialOfferItem.dart';
import '../../core/utils/AppDimens.dart';
import '../common_widgets/NoInternetLayout.dart';

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
    _specialOffersProvider.fetchSpecialOffersTimer();
    selectedFlavor = FlavorConfig.instance.flavor!;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SpecialOffersProvider, InternetStatusProvider>(
        builder: (context, provider, internetProvider, child) {
      return Stack(
        children: [
          /*(provider.specialOffers != null && provider.specialOffers!.isNotEmpty)
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
              : Container(),*/

          internetProvider.hasInternet
              ? Container(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: Column(
                    children: [
                      (provider.offersFilters != null &&
                              provider.offersFilters!.isNotEmpty)
                          ? SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      child: InkWell(
                                        customBorder: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        onTap: () {
                                          if (provider.selectedFilter ==
                                              provider.offersFilters![index]) {
                                            provider.updateSelectedFilter(null);
                                          } else {
                                            provider.updateSelectedFilter(
                                                provider.offersFilters![index]);
                                          }
                                        },
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25),
                                              decoration: BoxDecoration(
                                                color: provider.selectedFilter !=
                                                            null &&
                                                        provider.offersFilters![
                                                                index] ==
                                                            provider
                                                                .selectedFilter
                                                    ? Colors.white
                                                    : Theme.of(context)
                                                        .primaryColorDark,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .buttonTheme
                                                        .colorScheme!
                                                        .onSecondary),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                provider.offersFilters![index]
                                                    .toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      color: provider.selectedFilter !=
                                                                  null &&
                                                              provider.offersFilters![
                                                                      index] ==
                                                                  provider
                                                                      .selectedFilter
                                                          ? Theme.of(context)
                                                              .primaryColorDark
                                                          : Theme.of(context)
                                                              .textSelectionTheme
                                                              .selectionColor,
                                                    ),
                                              ),
                                            )),
                                      ));
                                },
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.offersFilters!.length,
                              ),
                            )
                          : const SizedBox.shrink(),
                      Expanded(
                        child: (provider.specialOffers != null)
                            ? (provider.specialOffers!.isNotEmpty)
                                ? RefreshIndicator(
                                    backgroundColor:
                                        Theme.of(context).primaryColorDark,
                                    color: Theme.of(context)
                                        .textSelectionTheme
                                        .selectionColor,
                                    onRefresh: () async {
                                      Provider.of<SpecialOffersProvider>(
                                              context,
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
                                  )
                                : Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.new_releases_rounded,
                                        size: 50,
                                      ),
                                      AppDimens.shape_15,
                                      Text(
                                        AppLocalizations.of(context)!
                                            .msgNoOffers,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .selectionColor,
                                            fontSize: 18),
                                      )
                                    ],
                                  ),
                                )
                            : SizedBox.shrink(),
                      ),
                    ],
                  ),
                )
              : NoInternetLayout(),
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
