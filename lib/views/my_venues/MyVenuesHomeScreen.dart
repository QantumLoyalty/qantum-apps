import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/view_models/InternetStatusProvider.dart';
import 'package:qantum_apps/views/common_widgets/NoInternetLayout.dart';
import '../../core/enums/AdvertisementEnums.dart';
import '/view_models/HomeProvider.dart';
import '../../core/flavors_config/flavor_config.dart';
import '../../views/my_venues/widgets/PromotionsPlaceHolder.dart';
import '../../view_models/PromotionsProvider.dart';
import '../../views/common_widgets/AppLoader.dart';
import '../../core/utils/AppDimens.dart';
import '../dialogs/PromotionDetailDialog.dart';
import '../dialogs/SpinnerDialog.dart';

class MyVenuesHomeScreen extends StatefulWidget {
  const MyVenuesHomeScreen({super.key});

  @override
  State<MyVenuesHomeScreen> createState() => _MyVenuesHomeScreenState();
}

class _MyVenuesHomeScreenState extends State<MyVenuesHomeScreen>
    with SingleTickerProviderStateMixin {
  double scaleValue = 1.0;
  double largeAdvHeight = 180.0;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Flavor flavor;

  @override
  void initState() {
    super.initState();
    Provider.of<PromotionsProvider>(context, listen: false)
        .fetchPromotionsTimer();
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Consumer3<PromotionsProvider, HomeProvider,
                  InternetStatusProvider>(
              builder:
                  (context, provider, homeProvider, internetProvider, child) {
            largeAdvHeight = (flavor == Flavor.mhbc) ? 180 : 210;

            return Stack(
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
                                        provider.promotions!.largePromotions !=
                                                    null &&
                                                provider.promotions!
                                                    .largePromotions!.isNotEmpty
                                            ? CarouselSlider.builder(
                                                itemCount: provider.promotions!
                                                    .largePromotions!.length,
                                                itemBuilder:
                                                    (context, index, position) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5, right: 5),
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

                                                                PromotionDetailDialog
                                                                        .getInstance()
                                                                    .showPromotionDetailDialog(
                                                                        context,
                                                                        provider
                                                                            .promotions!
                                                                            .largePromotions![index],
                                                                        AdvertisementEnums.large);
                                                              },
                                                              child: SizedBox(
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
                                                                          .largePromotions![
                                                                              index]
                                                                          .imageUrl ??
                                                                      "",
                                                                  placeholder:
                                                                      (context,
                                                                          _) {
                                                                    return const Stack(
                                                                      children: [
                                                                        Center(
                                                                          child: SizedBox(
                                                                              width: 50,
                                                                              height: 50,
                                                                              child: CircularProgressIndicator()),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                  errorWidget:
                                                                      (context,
                                                                          _,
                                                                          obj) {
                                                                    return PromotionsPlaceHolder(
                                                                        size: Size(
                                                                            MediaQuery.of(context).size.width,
                                                                            200));
                                                                  },
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ), /*AspectRatio(
                                                        aspectRatio: 16 / 9,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: provider
                                                                  .promotions!
                                                                  .largePromotions![
                                                                      index]
                                                                  .imageUrl ??
                                                              "",
                                                          placeholder:
                                                              (context, _) {
                                                            return const Stack(
                                                              children: [
                                                                Center(
                                                                  child: SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child:
                                                                          CircularProgressIndicator()),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                          errorWidget: (context,
                                                              _, obj) {
                                                            return PromotionsPlaceHolder(
                                                                size: Size(
                                                                    MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width,
                                                                    200));
                                                          },
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),*/
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                options: CarouselOptions(
                                                    autoPlay: false,
                                                    reverse: false,
                                                    enableInfiniteScroll: false,
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
                                                  itemBuilder: (context, index,
                                                      position) {
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
                                                                PromotionDetailDialog
                                                                        .getInstance()
                                                                    .showPromotionDetailDialog(
                                                                        context,
                                                                        provider.promotions!.smallPromotions![2 *
                                                                            index],
                                                                        AdvertisementEnums
                                                                            .small);
                                                              },
                                                              child:
                                                                  AspectRatio(
                                                                aspectRatio: 1,
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
                                                                    return const Stack(
                                                                      children: [
                                                                        Center(
                                                                          child: SizedBox(
                                                                              width: 30,
                                                                              height: 30,
                                                                              child: CircularProgressIndicator()),
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
                                                                          MediaQuery.of(context)
                                                                              .size
                                                                              .width,
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
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      homeProvider.updateShowAllMenuVisibility(
                                                                          false,
                                                                          "Large Promotions Item");

                                                                      PromotionDetailDialog.getInstance().showPromotionDetailDialog(
                                                                          context,
                                                                          provider
                                                                              .promotions!
                                                                              .smallPromotions![2 *
                                                                                  index +
                                                                              1],
                                                                          AdvertisementEnums
                                                                              .small);
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
                                                                            provider.promotions!.smallPromotions![2 * index + 1].imageUrl ??
                                                                                "",
                                                                        placeholder:
                                                                            (context,
                                                                                _) {
                                                                          return const Stack(
                                                                            children: [
                                                                              Center(
                                                                                child: SizedBox(width: 30, height: 30, child: CircularProgressIndicator()),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                        errorWidget: (context,
                                                                            a,
                                                                            object) {
                                                                          return PromotionsPlaceHolder(
                                                                            size:
                                                                                Size(MediaQuery.of(context).size.width, 130),
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
                        : Container()
                    : NoInternetLayout(),
                provider.showLoader != null && provider.showLoader!
                    ? AppLoader()
                    : Container()
              ],
            );
          }),
        ),
        /*Container(
            padding: const EdgeInsets.only(top: 15),
            child: */ /*Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.txtCongratulations,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              Text(
                'You\'ve earned a free main course at Vinny\'s Italian',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textSelectionTheme.selectionColor,
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                          style: AppThemeCustom.getMoreInfoButtonStyle(context),
                          onPressed: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text(
                              AppStrings.txtMoreInfo.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: AppThemeCustom.getMoreInfoTextStyle(
                                    context),
                              ),
                            ),
                          )),
                    ],
                  )),
                  AppDimens.shape_10,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          style: AppThemeCustom.getRedeemButtonStyle(context),
                          onPressed: () {
                            showGeneralDialog(
                                context: context,
                                transitionDuration:
                                    const Duration(milliseconds: 500),
                                pageBuilder: (context, anim1, anim2) {
                                  return const Dialog(
                                    backgroundColor: Colors.transparent,
                                    insetPadding: EdgeInsets.zero,
                                    child: SpinnerDialog(),
                                  );
                                },
                                transitionBuilder:
                                    (context, anim1, anim2, child) {
                                  return BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 4 * anim1.value,
                                        sigmaY: 4 * anim1.value),
                                    child: SlideTransition(
                                      position: Tween(
                                              begin: const Offset(0, -1),
                                              end: const Offset(0, 0))
                                          .animate(anim1),
                                      child: child,
                                    ),
                                  );
                                });

                            */ /* */ /*showDialog(
                                context: context,
                                builder: (context) => const Dialog(
                                    backgroundColor: Colors.transparent,
                                    insetPadding: EdgeInsets.zero,
                                    child: SpinnerDialog()));*/ /* */ /*
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              AppStrings.txtRedeem.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color:
                                    AppThemeCustom.getRedeemTextStyle(context),
                              ),
                            ),
                          )),
                    ],
                  )),
                ],
              )
            ],
          ),*/
        (FlavorConfig.instance.flavor == Flavor.maxx)
            ? GestureDetector(
                onTapUp: scaleSpinToPlay(1.0),
                onTapDown: scaleSpinToPlay(0.8),
                onTapCancel: scaleSpinToPlay(1.0),
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
                              sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
                          child: SlideTransition(
                            position: Tween(
                                    begin: const Offset(0, -1),
                                    end: const Offset(0, 0))
                                .animate(anim1),
                            child: child,
                          ),
                        );
                      });
                },
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Image.asset('assets/common/spin_to_play.png'),
                ))
            : Container()
      ],
    );
  }

  scaleSpinToPlay(double scale) {
    setState(() {
      scaleValue = scale;
    });
  }
}
