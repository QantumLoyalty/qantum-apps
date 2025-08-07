import 'dart:async';

import 'package:condition_builder/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';
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
  Timer? _pointsDialogTimer;
  late HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      Provider.of<UserInfoProvider>(context, listen: false).retrieveUserInfo();
      Provider.of<UserInfoProvider>(context, listen: false)
          .runFetchProfileTimer();
      Provider.of<UserInfoProvider>(context, listen: false)
          .uploadDeviceDetail();
      Provider.of<UserInfoProvider>(context, listen: false).checkForAppUpdate();
      _homeProvider = Provider.of<HomeProvider>(context, listen: false);
      _homeProvider.getAllOptionsTimer();
    }
  }

  startPointsDialogTimer() {
    _pointsDialogTimer = Timer(const Duration(seconds: 2), () {
      _homeProvider.updatePointsBalanceVisibility(false);
      // _homeProvider.updateSelectedOption(_homeProvider.prevSelectedOption);
    });
  }

  cancelPointsDialogTimer() {
    if (_pointsDialogTimer != null && _pointsDialogTimer!.isActive) {
      _pointsDialogTimer!.cancel();
    }
  }

  @override
  void dispose() {
    cancelPointsDialogTimer();
    super.dispose();
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
                    /*Positioned.fill(
                        child: provider
                                    .homeNavigationList[provider.selectedOption]
                                    .type ==
                                HomeNavigatorModel.typeScreen
                            ? provider.selectedScreen
                            : provider
                                .homeNavigationList[provider.prevSelectedOption]
                                .screen)*/

                    ConditionBuilder<Widget>.on(
                        () =>
                            provider.homeNavigationList[provider.selectedOption]
                                .type ==
                            HomeNavigatorModel.typeScreen,
                        () =>
                            provider.selectedScreen).build(
                        orElse: () => provider
                            .homeNavigationList[provider.prevSelectedOption]
                            .screen),
                    (provider.showPointsBalance)
                        ? const PointsBalanceWidget()
                        : Container(),
                    checkForSeeAllMenu(provider)
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
                            iconColor: (index == 2) ? Colors.transparent : null,
                            text: provider.homeNavigationList[index].name
                                .replaceAll(" ", "\n")
                                .toUpperCase(),
                            textColor: (index == 2)
                                ? Colors.transparent
                                : Theme.of(context)
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
                                    color:  Theme.of(context)
                                            .buttonTheme
                                            .colorScheme!
                                            .onSecondary,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            onClick: () {
                              /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                              // checkAndHideSeeAllOptionMenu(provider);

                              // provider.updateSelectedOption(index);
                            },
                            onDragStart: (value) {
                              /// HIDE POINTS BALANCE DIALOG
                              if (provider.homeNavigationList[index].name ==
                                  provider.homeNavigationList[0].name) {
                                provider.updatePointsBalanceVisibility(false);
                                provider.updateSelectedOption(
                                    provider.prevSelectedOption);
                              }
                            },
                            onTapUp: (value) async {
                              /// HIDE POINTS BALANCE DIALOG
                              /*if (provider.homeNavigationList[index].name ==
                                  provider.homeNavigationList[0].name) {
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                provider.updatePointsBalanceVisibility(false);
                                provider.updateSelectedOption(
                                    provider.prevSelectedOption);
                              }*/
                              startPointsDialogTimer();
                            },
                            onTapDown: (value) {
                              /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                              checkAndHideSeeAllOptionMenu(
                                  provider, "points balance");
                              if (provider.homeNavigationList[index].name ==
                                  provider.homeNavigationList[2].name) {
                                /// DO NOTHING
                              } else {
                                provider.updateSelectedOption(index);

                                if (provider.homeNavigationList[index].name ==
                                    provider.homeNavigationList[0].name) {
                                  /// SHOW POINTS BALANCE DIALOG
                                  provider.updatePointsBalanceVisibility(true);
                                } else {
                                  /// HIDE & CHECK IF POINTS BALANCE MENU IS VISIBLE OR NOT
                                  checkAndHidePointsBalance(
                                      provider, "FROM TOP ROW");
                                }
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
                            iconColor:
                                (provider.homeNavigationList[index + 3].name ==
                                            AppStrings.txtSeeAll &&
                                        (provider.moreButtonsMap == null ||
                                            provider.moreButtonsMap!.isEmpty))
                                    ? Colors.transparent
                                    : null,
                            text: provider.homeNavigationList[index + 3].name
                                .replaceAll(" ", "\n")
                                .toUpperCase(),
                            margin: const EdgeInsets.all(5),
                            textSize: 13,
                            textColor:
                                (provider.homeNavigationList[index + 3].name ==
                                            AppStrings.txtSeeAll &&
                                        (provider.moreButtonsMap == null ||
                                            provider.moreButtonsMap!.isEmpty))
                                    ? Colors.transparent
                                    : Theme.of(context)
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
                                        .onSecondary,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            onClick: () {
                              /// HIDE & CHECK IF POINTS BALANCE MENU IS VISIBLE OR NOT
                              checkAndHidePointsBalance(
                                  provider, "FROM SECOND ROW");

                              if (provider.homeNavigationList[index + 3].name !=
                                  provider.homeNavigationList[5].name) {
                                /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                                //  checkAndHideSeeAllOptionMenu(provider,"checkAndHideSeeAllOptionMenu myVenue");
                                //  provider.updateShowAllMenuVisibility(false, "checkAndHideSeeAllOptionMenu myVenue");
                                if (provider.showSeeAllMenu == true &&
                                    (provider.homeNavigationList[index + 3]
                                            .name !=
                                        provider.homeNavigationList[6].name)) {
                                  provider.updateShowAllMenuVisibility(
                                      false, "");
                                }

                                provider.updateSelectedOption(index + 3);
                              }

                              if (provider.homeNavigationList[index + 3].name ==
                                  provider.homeNavigationList[4].name) {
                                /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                                checkAndHideSeeAllOptionMenu(provider,
                                    "checkAndHideSeeAllOptionMenu mybenefits");

                                /// SHOW MY BENEFITS DIALOG
                                MyBenefitsDialog.getInstance()
                                    .showBenefitsDialog(context);
                              } else if (provider
                                      .homeNavigationList[index + 3].name ==
                                  provider.homeNavigationList[5].name) {
                                /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                                checkAndHideSeeAllOptionMenu(provider,
                                    "checkAndHideSeeAllOptionMenu myAccountScreen");

                                AppNavigator.navigateTo(
                                    context, AppNavigator.myAccountScreen);

                                provider.updateSelectedOption(
                                    provider.prevSelectedOption);
                              } else if (provider
                                      .homeNavigationList[index + 3].name ==
                                  provider.homeNavigationList[6].name) {
                                /// SEE ALL DIALOG VISIBILITY

                                if (provider.showSeeAllMenu) {
                                  /// SEE ALL DIALOG IS VISIBLE WE NEED TO HIDE IT
                                  /*   provider.updateSelectedOption(
                                      provider.prevSelectedOption);*/
                                  provider.updateShowAllMenuVisibility(
                                      false, "SeeAllMenu");
                                } else {
                                  /// SEE ALL DIALOG IS NOT VISIBLE WE NEED TO SHOW IT
                                  provider.updateShowAllMenuVisibility(
                                      true, "SeeAllMenu");
                                }
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

  Widget checkForSeeAllMenu(HomeProvider provider) {
    print("showSeeAllMenu --> ${provider.showSeeAllMenu}");
    return provider.showSeeAllMenu ? const AllMenuItemsWidget() : Container();
    /*if (provider.moreButtonsMap != null &&
        provider.moreButtonsMap!.isNotEmpty) {
      return provider.showSeeAllMenu ? const AllMenuItemsWidget() : Container();
    } else {
      return Container();
    }*/
  }

  checkAndHideSeeAllOptionMenu(HomeProvider provider, String from) {
    if (provider.showSeeAllMenu) {
      provider.updateShowAllMenuVisibility(false, from);
    }
  }

  checkAndHidePointsBalance(HomeProvider provider, String from) {
    if (provider.showPointsBalance) {
      provider.updatePointsBalanceVisibility(false);
    }
    cancelPointsDialogTimer();
  }
}
