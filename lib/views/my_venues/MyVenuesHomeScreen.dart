import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../views/my_venues/widgets/PromotionsPlaceHolder.dart';
import '../../view_models/PromotionsProvider.dart';
import '../../views/common_widgets/AppLoader.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';
import '../dialogs/PromotionDetailDialog.dart';

class MyVenuesHomeScreen extends StatefulWidget {
  const MyVenuesHomeScreen({super.key});

  @override
  State<MyVenuesHomeScreen> createState() => _MyVenuesHomeScreenState();
}

class _MyVenuesHomeScreenState extends State<MyVenuesHomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<PromotionsProvider>(context, listen: false)
        .fetchPromotionsTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child:
              Consumer<PromotionsProvider>(builder: (context, provider, child) {
            /*if (provider.isFetching) {
              Future.delayed(Duration.zero, () {
                setState(() {});
              });
            }*/

            return Stack(
              children: [
                provider.promotions != null
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            provider.promotions!.largePromotions != null &&
                                    provider
                                        .promotions!.largePromotions!.isNotEmpty
                                ? SizedBox(
                                    height: 220,
                                    width: MediaQuery.of(context).size.width,
                                    child: CarouselSlider.builder(
                                      itemCount: provider
                                          .promotions!.largePromotions!.length,
                                      itemBuilder: (context, index, position) {
                                        return ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: InkWell(
                                            onTap: () {
                                              PromotionDetailDialog
                                                      .getInstance()
                                                  .showPromotionDetailDialog(
                                                      context,
                                                      provider.promotions!
                                                              .largePromotions![
                                                          index]);
                                            },
                                            child: AspectRatio(
                                              aspectRatio: 9 / 6,
                                              child: CachedNetworkImage(
                                                height: 220,
                                                imageUrl: provider
                                                        .promotions!
                                                        .largePromotions![index]
                                                        .imageUrl ??
                                                    "",
                                                placeholder: (context, _) {
                                                  return const Stack(
                                                    children: [
                                                      Center(
                                                        child: SizedBox(
                                                            width: 50,
                                                            height: 50,
                                                            child:
                                                                CircularProgressIndicator()),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                errorWidget: (context, _, obj) {
                                                  return PromotionsPlaceHolder(
                                                      size: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          200));
                                                },
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      options: CarouselOptions(
                                          aspectRatio: 5 / 9,
                                          autoPlay: false,
                                          reverse: false,
                                          enableInfiniteScroll: false,
                                          enlargeCenterPage: true,
                                          viewportFraction: 0.80,
                                          initialPage: 0,
                                          onPageChanged:
                                              (index, reason) async {}),
                                    ))
                                : Container(),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 12),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, position) {
                                    print(
                                        "Small Promotions Length ${provider.promotions!.smallPromotions!.length / 2} Pages: ${((provider.promotions!.smallPromotions!.length / 2).floor() + provider.promotions!.smallPromotions!.length % 2)}");

                                    return (provider.promotions!
                                                    .smallPromotions !=
                                                null &&
                                            provider.promotions!
                                                .smallPromotions!.isNotEmpty)
                                        ? Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
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
                                              itemBuilder:
                                                  (context, index, position) {
                                                return Row(
                                                  children: [
                                                    Expanded(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: InkWell(
                                                          onTap: () {
                                                            PromotionDetailDialog
                                                                    .getInstance()
                                                                .showPromotionDetailDialog(
                                                                    context,
                                                                    provider
                                                                        .promotions!
                                                                        .smallPromotions![2 * index]);
                                                          },
                                                          child: AspectRatio(
                                                            aspectRatio: 1,
                                                            child:
                                                                CachedNetworkImage(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: 130,
                                                              fit: BoxFit.fill,
                                                              imageUrl: provider
                                                                      .promotions!
                                                                      .smallPromotions![2 *
                                                                          index]
                                                                      .imageUrl ??
                                                                  "",
                                                              placeholder:
                                                                  (context, _) {
                                                                return const Stack(
                                                                  children: [
                                                                    Center(
                                                                      child: SizedBox(
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              30,
                                                                          child:
                                                                              CircularProgressIndicator()),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                              errorWidget:
                                                                  (context, a,
                                                                      object) {
                                                                return PromotionsPlaceHolder(
                                                                  size: Size(
                                                                      MediaQuery.of(
                                                                              context)
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
                                                      child: (2 * index + 1 <=
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
                                                              child: InkWell(
                                                                onTap: () {
                                                                  PromotionDetailDialog.getInstance().showPromotionDetailDialog(
                                                                      context,
                                                                      provider
                                                                          .promotions!
                                                                          .smallPromotions![2 *
                                                                              index +
                                                                          1]);
                                                                },
                                                                child:
                                                                    AspectRatio(
                                                                  aspectRatio:
                                                                      1,
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    imageUrl: provider
                                                                            .promotions!
                                                                            .smallPromotions![2 * index +
                                                                                1]
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
                                                                            MediaQuery.of(context).size.width,
                                                                            130),
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
                                                  enableInfiniteScroll: false,
                                                  enlargeCenterPage: true,
                                                  viewportFraction: 0.8,
                                                  initialPage: 0,
                                                  onPageChanged:
                                                      (index, reason) async {}),
                                            ),
                                          )
                                        : Container();
                                  },
                                  itemCount: 1,
                                )),
                          ],
                        ),
                      )
                    : Container(),
                provider.showLoader != null && provider.showLoader!
                    ? AppLoader()
                    : Container()
              ],
            );
          }),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
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
                          style: TextButton.styleFrom(
                              minimumSize: const Size(85, 30),
                              padding: EdgeInsets.zero,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark),
                          onPressed: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text(
                              AppStrings.txtMoreInfo.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
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
                          style: ButtonStyle(
                              shadowColor: WidgetStatePropertyAll(
                                  Colors.black.withValues(alpha: 0.4)),
                              elevation: const WidgetStatePropertyAll(20),
                              shape:
                                  WidgetStatePropertyAll(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(80))),
                              backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context)
                                      .buttonTheme
                                      .colorScheme!
                                      .primary)),
                          /*style: TextButton.styleFrom(
                              minimumSize: const Size(85, 30),
                              padding: EdgeInsets.zero,

                              backgroundColor: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .secondary),*/
                          onPressed: () {},
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              AppStrings.txtRedeem.toUpperCase(),
                              style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                              ),
                            ),
                          )),
                    ],
                  )),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
