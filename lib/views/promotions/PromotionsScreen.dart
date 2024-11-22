import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qantum_apps/core/navigation/AppNavigator.dart';

class PromotionsScreen extends StatelessWidget {
  List<Color> colorsList = [
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.blueGrey
  ];

  PromotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 210,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            items: colorsList.map((item) {
              return InkWell(
                onTap: () {
                  AppNavigator.navigateTo(
                      context, AppNavigator.promotionDetail);
                },
                child: Container(
                  color: item,
                ),
              );
            }).toList() as List<Widget>,
            options: CarouselOptions(
                aspectRatio: 5 / 9,
                autoPlay: false,
                reverse: true,
                enlargeCenterPage: true,
                viewportFraction: 0.80,
                initialPage: 0,
                onPageChanged: (index, reason) async {
                  /// Uncomment to Enable Ads
                  /*if (userInfoProvider
              .userPlan !=
              null &&
              AppHelper.getSubscriptionPlanName(
                  userInfoProvider
                      .userPlan!
                      .planName!)
                  .trim()
                  .toLowerCase() ==
                  SubscriptionEntitlement
                      .Breather.name
                      .toLowerCase()) {
            /// Uncomment to Enable Ads
            if (adProvider
                .checkSlideCountToAdShow()) {
              await adProvider
                  .showInterstitialAd();
            } else {
              await adProvider
                  .createInterstitialAd();
            }
          }
          snapshotProvider
              .setCurrentCarouselIndex(
              index + 1);
          snapshotProvider
              .setCurrentIndex(index);*/
                }),
          ),
        )

        /*SizedBox(
          height: 220,
          child: PageView.builder(
              itemCount: colorsList.length,
              controller: PageController(viewportFraction: 0.85),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: () {
                      AppNavigator.navigateTo(
                          context, AppNavigator.promotionDetail);
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2)),
                      child: Container( color: colorsList[index],height: 110,),
                    ),
                  ),
                );
              }),
        ),*/
      ],
    );
  }
}
