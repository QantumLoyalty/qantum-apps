import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import '/l10n/app_localizations.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppIcons.dart';
import '../../view_models/HomeProvider.dart';
import '../../view_models/UserInfoProvider.dart';

class MyBenefitsWidget extends StatefulWidget {
  const MyBenefitsWidget({super.key});

  @override
  State<MyBenefitsWidget> createState() => _MyBenefitsWidgetState();
}

class _MyBenefitsWidgetState extends State<MyBenefitsWidget> {
  var goldBenefitsList = [
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

  @override
  void initState() {
    super.initState();
    Provider.of<UserInfoProvider>(context, listen: false).getUsersBenefits();

    homeProvider = Provider.of<HomeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Consumer<UserInfoProvider>(builder: (context, provider, child) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(left: 25, right: 25),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7 - 80,
                child: Consumer<UserInfoProvider>(
                    builder: (context, provider, child) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          AppIcons.getCardBackground(
                              AppHelper.getUserTierType(provider.getUserInfo!)),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppHelper.getUserTierType(provider.getUserInfo!)
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
                              AppLocalizations.of(context)!
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
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Stack(
                                children: [
                                  (provider.benefitItems != null &&
                                          provider.benefitItems!.isNotEmpty)
                                      ? Positioned.fill(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: ListView.builder(
                                            itemCount:
                                                provider.benefitItems!.length -
                                                    1,
                                            itemBuilder: (BuildContext context,
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
                                                        .benefitItems![index],
                                                  ))
                                                ],
                                              );
                                            },
                                          ))
                                      : Container(),
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
                                      : Container()
                                ],
                              ),
                            )),
                            AppDimens.shape_20,
                          ],
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 50,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: ExactAssetImage(
                      AppIcons.getCardBackground(
                          AppHelper.getUserTierType(provider.getUserInfo!)),
                    ),
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
          );
        }),
      ),
    );
  }
}
