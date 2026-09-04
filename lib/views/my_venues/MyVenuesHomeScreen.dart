import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/views/common_widgets/BouncyButton.dart';

import '/view_models/HomeProvider.dart';
import '/view_models/InternetStatusProvider.dart';
import '/views/common_widgets/NoInternetLayout.dart';
import '../../core/enums/AdvertisementEnums.dart';
import '../../core/extensions/spacer_extension.dart';
import '../../core/flavors_config/flavor_config.dart';
import '../../core/utils/AppDimens.dart';
import '../../view_models/PromotionsProvider.dart';
import '../../views/common_widgets/AppLoader.dart';
import '../../views/my_venues/widgets/PromotionsPlaceHolder.dart';
import '../dialogs/PromotionDetailDialog.dart';
import '../dialogs/ScratchCardDialog.dart';
import 'widgets/MegaEntryWidget.dart';

class MyVenuesHomeScreen extends StatefulWidget {
  const MyVenuesHomeScreen({super.key});

  @override
  State<MyVenuesHomeScreen> createState() => _MyVenuesHomeScreenState();
}

class _MyVenuesHomeScreenState extends State<MyVenuesHomeScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  double scaleValue = 1.0;
  double largeAdvHeight = 180.0;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Flavor flavor;
  bool? isSmallScreen;
  late PromotionsProvider _promotionsProvider;
  late HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _promotionsProvider =
        Provider.of<PromotionsProvider>(context, listen: false);
    _promotionsProvider.fetchPromotionsTimer();
    fetchSpecialIncentives(context);

    flavor = FlavorConfig.instance.flavor!;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
      lowerBound: 0.9,
      upperBound: 1.0,
    );

    _scaleAnimation = _controller.drive(Tween(begin: 1.0, end: 0.9));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse(); // Return to normal size
      }
    });
  }

  fetchSpecialIncentives(BuildContext context) {
    Provider.of<PromotionsProvider>(context, listen: false)
        .fetchSpecialIncentivesTimer();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _promotionsProvider.stopPromotionsTimer();
        _promotionsProvider.stopSpecialIncentivesTimer();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      _promotionsProvider.stopPromotionsTimer();
      _promotionsProvider.stopSpecialIncentivesTimer();
      break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _promotionsProvider.stopPromotionsTimer();
    _promotionsProvider.stopSpecialIncentivesTimer();   
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isSmallScreen = MediaQuery.sizeOf(context).height < 900;
    return Consumer3<PromotionsProvider, HomeProvider, InternetStatusProvider>(
      builder: (context, provider, homeProvider, internetProvider, child) {
        final bool hasSmartIncentives = switch (flavor) {
          Flavor.hogansReward ||
          Flavor.mhbc ||
          Flavor.flinders ||
          Flavor.edp ||
          Flavor.qantum ||
          Flavor.bluewater ||
          Flavor.maxx ||
          Flavor.mosaic ||
          Flavor.maxClub =>
            true,
          _ => false,
        };
        final bool isMhbc = flavor == Flavor.mhbc;
        final bool isMaxClub = flavor == Flavor.maxClub;
        final double largeAdvHeight = isMhbc ? 180.0 : 210.0;

        return Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  internetProvider.hasInternet
                      ? provider.promotions != null
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: largeAdvHeight,
                                      width: MediaQuery.of(context).size.width,
                                      child:
                                          provider.promotions!
                                                          .largePromotions !=
                                                      null &&
                                                  provider
                                                      .promotions!
                                                      .largePromotions!
                                                      .isNotEmpty
                                              ? CarouselSlider.builder(
                                                  itemCount: provider
                                                      .promotions!
                                                      .largePromotions!
                                                      .length,
                                                  itemBuilder: (context, index,
                                                      position) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      child: Stack(
                                                        children: [
                                                          Center(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: InkWell(
                                                                  onTap: () {
                                                                    homeProvider
                                                                        .updateShowAllMenuVisibility(
                                                                            false,
                                                                            "Large Promotions Item");

                                                                    PromotionDetailDialog.getInstance().showPromotionDetailDialog(
                                                                        context,
                                                                        provider
                                                                            .promotions!
                                                                            .largePromotions![index],
                                                                        AdvertisementEnums.large);
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    height:
                                                                        largeAdvHeight,
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl: provider
                                                                              .promotions!
                                                                              .largePromotions![index]
                                                                              .imageUrl ??
                                                                          "",
                                                                      placeholder:
                                                                          (context,
                                                                              _) {
                                                                        return const Stack(
                                                                          children: [
                                                                            Center(
                                                                              child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator()),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                      errorWidget:
                                                                          (context,
                                                                              _,
                                                                              obj) {
                                                                        return PromotionsPlaceHolder(
                                                                            size:
                                                                                Size(MediaQuery.of(context).size.width, 200));
                                                                      },
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  )),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  options: CarouselOptions(
                                                      autoPlay: false,
                                                      reverse: false,
                                                      enableInfiniteScroll:
                                                          false,
                                                      enlargeCenterPage: false,
                                                      viewportFraction: 0.8,
                                                      initialPage: 0,
                                                      onPageChanged: (index,
                                                          reason) async {}),
                                                )
                                              : Container()),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12, top: 10),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, position) {
                                          return (provider.promotions!
                                                          .smallPromotions !=
                                                      null &&
                                                  provider
                                                      .promotions!
                                                      .smallPromotions!
                                                      .isNotEmpty)
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 0),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 130,
                                                  child: CarouselSlider.builder(
                                                    itemCount: ((provider
                                                                    .promotions!
                                                                    .smallPromotions!
                                                                    .length /
                                                                2)
                                                            .floor() +
                                                        provider
                                                                .promotions!
                                                                .smallPromotions!
                                                                .length %
                                                            2),
                                                    itemBuilder: (context,
                                                        index, position) {
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  homeProvider
                                                                      .updateShowAllMenuVisibility(
                                                                          false,
                                                                          "Large Promotions Item");
                                                                  PromotionDetailDialog.getInstance().showPromotionDetailDialog(
                                                                      context,
                                                                      provider.promotions!
                                                                              .smallPromotions![
                                                                          2 *
                                                                              index],
                                                                      AdvertisementEnums
                                                                          .small);
                                                                },
                                                                child:
                                                                    AspectRatio(
                                                                  aspectRatio:
                                                                      1,
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    height: 130,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    imageUrl: provider
                                                                            .promotions!
                                                                            .smallPromotions![2 *
                                                                                index]
                                                                            .imageUrl ??
                                                                        "",
                                                                    placeholder:
                                                                        (context,
                                                                            _) {
                                                                      return  Stack(
                                                                        children: [
                                                                          Center(
                                                                            child: SizedBox(
                                                                                width: 30,
                                                                                height: 30,
                                                                                child: CircularProgressIndicator(color: Theme.of(context).textSelectionTheme.selectionColor,)),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                    errorWidget:
                                                                        (context,
                                                                            a,
                                                                            object) {
                                                                      return PromotionsPlaceHolder(
                                                                        size: Size(
                                                                            MediaQuery.of(context).size.width,
                                                                            130),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          AppDimens.shape_10,
                                                          Expanded(
                                                            child: (2 * index +
                                                                        1 <=
                                                                    provider
                                                                            .promotions!
                                                                            .smallPromotions!
                                                                            .length -
                                                                        1)
                                                                ? ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        homeProvider.updateShowAllMenuVisibility(
                                                                            false,
                                                                            "Large Promotions Item");

                                                                        PromotionDetailDialog.getInstance().showPromotionDetailDialog(
                                                                            context,
                                                                            provider.promotions!.smallPromotions![2 * index +
                                                                                1],
                                                                            AdvertisementEnums.small);
                                                                      },
                                                                      child:
                                                                          AspectRatio(
                                                                        aspectRatio:
                                                                            1,
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          imageUrl:
                                                                              provider.promotions!.smallPromotions![2 * index + 1].imageUrl ?? "",
                                                                          placeholder:
                                                                              (context, _) {
                                                                            return  Stack(
                                                                              children: [
                                                                                Center(
                                                                                  child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator(color:Theme.of(context).textSelectionTheme.selectionColor)),
                                                                                ),
                                                                              ],
                                                                            );
                                                                          },
                                                                          errorWidget: (context,
                                                                              a,
                                                                              object) {
                                                                            return PromotionsPlaceHolder(
                                                                              size: Size(MediaQuery.of(context).size.width, 130),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                    options: CarouselOptions(
                                                        aspectRatio: 5 / 9,
                                                        autoPlay: false,
                                                        reverse: false,
                                                        enableInfiniteScroll:
                                                            false,
                                                        enlargeCenterPage: true,
                                                        viewportFraction: 0.8,
                                                        initialPage: 0,
                                                        onPageChanged: (index,
                                                            reason) async {}),
                                                  ),
                                                )
                                              : Container();
                                        },
                                        itemCount: 1,
                                      )),
                                ],
                              ),
                            )
                          : const SizedBox.shrink()
                      : const NoInternetLayout(),
                  if (provider.showLoader == true) AppLoader(),
                ],
              ),
            ),
           // 10.h,
            /*if (isMaxClub)
              GestureDetector(
                onTapUp: (_) => scaleSpinToPlay(1.0),
                onTapDown: (_) => scaleSpinToPlay(0.8),
                onTapCancel: () => scaleSpinToPlay(1.0),
                onTap: () {
                  _controller.forward();

                  showGeneralDialog(
                    context: context,
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (context, anim1, anim2) {
                      return const Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.zero,
                        child: SpinnerDialog(),
                      );
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 4 * anim1.value,
                          sigmaY: 4 * anim1.value,
                        ),
                        child: SlideTransition(
                          position: Tween(
                            begin: const Offset(0, -1),
                            end: Offset.zero,
                          ).animate(anim1),
                          child: child,
                        ),
                      );
                    },
                  );
                },
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset('assets/common/spin_to_play.png'),
                ),
              ),*/
            if (hasSmartIncentives && provider.incentives.isNotEmpty)
              LayoutBuilder(
                builder: (context, constraints) {
                  const double minButtonHeight = 60.0;
                  const double maxButtonHeight = 120.0;

                  final double buttonHeight = constraints.maxHeight.clamp(
                    minButtonHeight,
                    maxButtonHeight,
                  );

                  return Center(
                    child: SizedBox(
                      height: buttonHeight,
                      //width: buttonHeight,
                      child: BouncyButton(
                        child: GifView.asset(
                          'assets/common/scratch_and_win.gif',
                          fit: BoxFit.contain,
                        ),
                        onTap: () async {
                          await ScratchCardDialog.getInstance()
                              .showScratchCardDialog(
                            context,
                            incentive: provider.incentives.first,
                          );

                          await fetchSpecialIncentives(context);
                        },
                      ),
                    ),
                  );
                },
              ),
              /*BouncyButton(
                child: GifView.asset('assets/common/scratch_and_win.gif'),
                onTap: () async {
                  await ScratchCardDialog.getInstance().showScratchCardDialog(
                      context,
                      incentive: provider.incentives.first);

                  await fetchSpecialIncentives(context);
                },
              ),*/
            //15.h,
            const MegaEntryWidget(),
          ],
        );
      },
    );
  }



  scaleSpinToPlay(double scale) {
    setState(() {
      scaleValue = scale;
    });
  }
}
