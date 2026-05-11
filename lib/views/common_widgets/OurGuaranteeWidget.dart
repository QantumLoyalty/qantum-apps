import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/flavors_config/flavor_config.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppIcons.dart';
import '../../core/utils/FlavorConstants.dart';
import '../../view_models/HomeProvider.dart';
import '../../view_models/UserInfoProvider.dart';

class OurGuaranteeWidget extends StatefulWidget {
  const OurGuaranteeWidget({super.key});

  @override
  State<OurGuaranteeWidget> createState() => _OurGuaranteeWidgetState();
}

class _OurGuaranteeWidgetState extends State<OurGuaranteeWidget> {
  late HomeProvider homeProvider;

  String? cardBackground;
  Flavor? flavor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userInfoProvider = context.read<UserInfoProvider>();
      userInfoProvider.checkInternetStatus();
      homeProvider = Provider.of<HomeProvider>(context, listen: false);
      cardBackground = AppIcons.getCardBackground(
          FlavorConstants.getUserTierType(userInfoProvider.getUserInfo!));
      flavor = FlavorConfig.instance.flavor!;
    });
  }

  static const String _guaranteeText =
      "Bob, ever a man of the people has sought fervently to get unbeatable prices for all his 'mates'. He's not some corporate organisation with a boardroom of suits. He's a true Queenslander born and bred, trying to give the people what they need; good priced booze.\n\n"
      "Unperturbed by what everyone else is doing, Bob will always make sure you get the fairest price for your booze. Whether it's for a Friday arvo beer after a long week on the tools, a Sunday roast with the family or a cold one after mowing the lawns.\n\n"
      "With stores planned all around Queensland; if you haven't got a Bob's near you, trust us, we're working on it. Local, loyal and a bit cheeky, Bob's Bulk Booze is your new place for all your favourite drinks!";

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final dialogHeight = media.size.height*0.8;

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
                        color:  AppColors.bob_button_color,
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(left: 25, right: 25),
                    width: media.size.width,
                    height: dialogHeight-80,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Image.asset(
                            AppIcons.app_logo,
                            height: 100,
                            width: 140,
                          ),
                          Text("Bob's Guarantee",
                            style: TextStyle(shadows: [
                              Shadow(
                                offset: const Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: AppColors.black.withValues(alpha: 0.5),
                              )
                            ], color: AppColors.white, fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                            child: Container(
                              width: media.size.width,
                              margin: const EdgeInsets.all(15),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const SingleChildScrollView(
                                child: Text(
                                  _guaranteeText,
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AppDimens.shape_20,
                        ],
                      ),
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
