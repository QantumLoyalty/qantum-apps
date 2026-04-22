import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/flavor_config.dart';

import '../../core/navigation/AppNavigator.dart';
import '/l10n/app_localizations.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppIcons.dart';
import '../../core/utils/FlavorConstants.dart';
import '../../view_models/HomeProvider.dart';
import '../../view_models/UserInfoProvider.dart';

class MyBenefitsWidget extends StatefulWidget {
  const MyBenefitsWidget({super.key});

  @override
  State<MyBenefitsWidget> createState() => _MyBenefitsWidgetState();
}

class _MyBenefitsWidgetState extends State<MyBenefitsWidget> {
  final goldBenefitsList = [
    "50% off Meals",
    "\$2 off Drinks",
    "Double Gaming Points",
    "Double F&B Points",
    "Points for Retail",
    "Complimentary Coffee",
    "Premium Offers",
    "Discounted Events"
  ];

  late HomeProvider homeProvider;
  String? cardBackground;
  Flavor? flavor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userInfoProvider = context.read<UserInfoProvider>();
      userInfoProvider.getUsersBenefits();
      userInfoProvider.checkInternetStatus();
      homeProvider = Provider.of<HomeProvider>(context, listen: false);
      cardBackground = AppIcons.getCardBackground(
          FlavorConstants.getUserTierType(userInfoProvider.getUserInfo!));
      flavor = FlavorConfig.instance.flavor!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final dialogHeight = media.size.height * 0.7;

    return Consumer<UserInfoProvider>(
        builder: (context, userInfoProvider, child) {
      return Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: double.infinity,
          height: dialogHeight,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: (flavor != null && flavor == Flavor.bobsBulkBooze)
                        ? AppColors.bob_button_color
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(left: 25, right: 25),
                width: media.size.width,
                height: dialogHeight - 80,
                child: Container(
                  decoration: BoxDecoration(
                    image: (flavor != null && flavor == Flavor.bobsBulkBooze)
                        ? null
                        : DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(
                              AppIcons.getCardBackground(
                                FlavorConstants.getUserTierType(
                                  userInfoProvider.getUserInfo!,
                                ),
                              ),
                            ),
                          ),
                  ),
                  child: Consumer<UserInfoProvider>(
                      builder: (context, provider, child) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (flavor != null && flavor == Flavor.senseOfTaste)
                              ? Image.asset(
                                  "assets/senseOfTaste/app_log_black.png",
                                  height: 100,
                                  width: 140,
                                )
                              : (flavor != null && flavor == Flavor.bobsBulkBooze)
                                  ? Image.asset(
                                      AppIcons.app_logo,
                                      height: 100,
                                      width: 140,
                                    )
                                  : Text(
                                      FlavorConstants.getUserTierType(
                                              provider.getUserInfo!)
                                          .toUpperCase(),
                                      style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              offset: const Offset(1.0, 1.0),
                                              blurRadius: 3.0,
                                              color: AppColors.black
                                                  .withValues(alpha: 0.5),
                                            )
                                          ],
                                          color: AppColors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                          Text(
                            (flavor != null && flavor == Flavor.bobsBulkBooze)
                                ? AppLocalizations.of(context)!
                                    .txtWeeklyDeals
                                    .toUpperCase()
                                : AppLocalizations.of(context)!
                                    .txtMembershipBenefits
                                    .toUpperCase(),
                            style: TextStyle(shadows: [
                              Shadow(
                                offset: const Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: AppColors.black.withValues(alpha: 0.5),
                              )
                            ], color: AppColors.white, fontSize: 18),
                          ),
                          Expanded(
                              child: Container(
                            width: media.size.width,
                            height: media.size.height,
                            margin: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(
                              children: [
                                (provider.internetStatus != null)
                                    ? (provider.internetStatus!
                                        ? (provider.benefitItems != null &&
                                                provider
                                                    .benefitItems!.isNotEmpty)
                                            ? Positioned.fill(
                                                top: 0,
                                                left: 0,
                                                right: 0,
                                                bottom: 0,
                                                child: ListView.builder(
                                                  itemCount: provider
                                                          .benefitItems!
                                                          .length -
                                                      1,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Row(
                                                      children: [
                                                        AppDimens.shape_10,
                                                        Icon(
                                                          Icons.check_circle,
                                                          size: 16,
                                                          color: AppColors
                                                              .getMembershipCategoryColor(
                                                                  provider
                                                                      .getUserInfo!
                                                                      .statusTier),
                                                        ),
                                                        Expanded(
                                                            child: Html(
                                                          data: provider
                                                                  .benefitItems![
                                                              index],
                                                              onLinkTap: (String? url,
                                                                  Map<String, String> attributes, _) {

                                                          //  debugPrint("Tapped URL: $url");

                                                                AppNavigator.navigateTo(
                                                                    context, AppNavigator.appWebView,
                                                                    arguments: url);
                                                              },
                                                        ))
                                                      ],
                                                    );
                                                  },
                                                ))
                                            : const SizedBox.shrink()
                                        : Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.wifi_off,
                                                  size: 30,
                                                  color: AppColors.black,
                                                ),
                                                AppDimens.shape_10,
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .msgNoInternet,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                    : const SizedBox.shrink(),
                                (provider.showLoader != null &&
                                        provider.showLoader!)
                                    ? const Center(
                                        child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                            )),
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                          )),
                          AppDimens.shape_20,
                        ],
                      ),
                    );
                  }),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 50,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: ExactAssetImage(AppIcons.getCardBackground(
                        FlavorConstants.getUserTierType(
                            userInfoProvider.getUserInfo!))),
                    radius: 30,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);

                          homeProvider.updateSelectedOption(
                              homeProvider.prevSelectedOption);
                        },
                        icon: const Icon(
                          Icons.clear,
                          size: 30,
                          color: Colors.white,
                        )),
                  ))
            ],
          ),
        ),
      );
    });
  }
}
