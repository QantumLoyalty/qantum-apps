import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../data/models/HomeNavigatorModel.dart';
import '../../view_models/HomeProvider.dart';
import '../../view_models/UserInfoProvider.dart';
import '../common_widgets/AppScaffold.dart';
import '../common_widgets/IconTextWidget.dart';
import '../dialogs/MyBenefitsDialog.dart';
import 'widgets/AllMenuItemsWidget.dart';
import 'widgets/HomeAppBar.dart';
import 'widgets/PointsBalanceWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      Provider.of<UserInfoProvider>(context, listen: false).retrieveUserInfo();
      //   Provider.of<UserInfoProvider>(context, listen: false).uploadDeviceToken();
      Provider.of<UserInfoProvider>(context, listen: false)
          .runFetchProfileTimer();
      // Provider.of<UserInfoProvider>(context, listen: false).fetchUserProfile();
      Provider.of<UserInfoProvider>(context, listen: false)
          .uploadDeviceDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Consumer2<HomeProvider, UserInfoProvider>(
              builder: (context, provider, userInfoProvider, child) {
            return Column(
              children: [
                const HomeAppBar(),
                AppDimens.shape_20,
                Expanded(
                    child: Stack(
                  children: [
                    Positioned.fill(
                        child: provider
                                    .homeNavigationList[provider.selectedOption]
                                    .type ==
                                HomeNavigatorModel.typeScreen
                            ? provider.selectedScreen
                            : provider
                                .homeNavigationList[provider.prevSelectedOption]
                                .screen),
                    (provider.showPointsBalance)
                        ? const PointsBalanceWidget()
                        : Container(),
                    (provider.showSeeAllMenu)
                        ? const AllMenuItemsWidget()
                        : Container()
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Column(
                    children: [
                      /// FIRST ROW --> POINTS BALANCE***SPECIAL OFFERS***PARTNER OFFERS <-- ///
                      Row(
                        children: List.generate(3, (index) {
                          return Expanded(
                              child: IconTextWidget(
                            orientation: IconTextWidget.VERTICAL,
                            icon: provider.homeNavigationList[index].icon,
                            text: provider.homeNavigationList[index].name
                                .replaceAll(" ", "\n")
                                .toUpperCase(),
                            textColor: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            margin: const EdgeInsets.all(5),
                            textSize: 13,
                            decoration: BoxDecoration(
                                color: (provider.selectedOption == index)
                                    ? Theme.of(context)
                                        .iconTheme
                                        .color!
                                        .withValues(alpha: 0.5)
                                    : Colors.transparent,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .buttonTheme
                                        .colorScheme!
                                        .primary,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            onClick: () {
                              /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                              checkAndHideSeeAllOptionMenu(provider);

                              provider.updateSelectedOption(index);
                            },
                            onTapUp: (value) {
                              /// HIDE POINTS BALANCE DIALOG
                              if (provider.homeNavigationList[index].name ==
                                  provider.homeNavigationList[0].name) {
                                provider.updatePointsBalanceVisibility(false);
                              }
                            },
                            onTapDown: (value) {
                              /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                              checkAndHideSeeAllOptionMenu(provider);

                              if (provider.homeNavigationList[index].name ==
                                  provider.homeNavigationList[0].name) {
                                /// SHOW POINTS BALANCE DIALOG
                                provider.updatePointsBalanceVisibility(true);
                              }
                            },
                          ));
                        }),
                      ),

                      /// SECOND ROW --> MY VENUE***MY BENEFITS***MY ACCOUNT***SEE ALL <-- ///
                      Row(
                        children: List.generate(4, (index) {
                          return Expanded(
                              child: IconTextWidget(
                            orientation: IconTextWidget.VERTICAL,
                            icon: provider.homeNavigationList[index + 3].icon,
                            text: provider.homeNavigationList[index + 3].name
                                .replaceAll(" ", "\n")
                                .toUpperCase(),
                            margin: const EdgeInsets.all(5),
                            textSize: 13,
                            textColor: Theme.of(context)
                                .textSelectionTheme
                                .selectionColor,
                            decoration: BoxDecoration(
                                color: (provider.selectedOption == index + 3)
                                    ? Theme.of(context)
                                        .iconTheme
                                        .color!
                                        .withValues(alpha: 0.5)
                                    : Colors.transparent,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .buttonTheme
                                        .colorScheme!
                                        .primary,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            onClick: () {
                              if (provider.homeNavigationList[index + 3].name !=
                                  provider.homeNavigationList[5].name) {
                                provider.updateSelectedOption(index + 3);
                              }

                              if (provider.homeNavigationList[index + 3].name ==
                                  provider.homeNavigationList[4].name) {
                                /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                                checkAndHideSeeAllOptionMenu(provider);

                                /// SHOW MY BENEFITS DIALOG
                                MyBenefitsDialog.getInstance()
                                    .showBenefitsDialog(context);
                              } else if (provider
                                      .homeNavigationList[index + 3].name ==
                                  provider.homeNavigationList[5].name) {
                                /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                                checkAndHideSeeAllOptionMenu(provider);

                                AppNavigator.navigateTo(
                                    context, AppNavigator.myAccountScreen);
                              } else if (provider
                                      .homeNavigationList[index + 3].name ==
                                  provider.homeNavigationList[6].name) {
                                provider.updateShowAllMenuVisibility(
                                    !provider.showSeeAllMenu);
                              }
                            },
                          ));
                        }),
                      ),
                    ],
                  ),
                ),
                AppDimens.shape_10,
              ],
            );
          }),
        ),
      ),
    );
  }

  checkAndHideSeeAllOptionMenu(HomeProvider provider) {
    if (provider.showSeeAllMenu) {
      provider.updateShowAllMenuVisibility(false);
    }
  }
}
