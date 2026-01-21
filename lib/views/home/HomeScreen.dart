import 'dart:async';
import 'dart:convert';
import 'package:condition_builder/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:provider/provider.dart';
import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/flavors_config/flavor_config.dart';
import '../../core/mixins/logging_mixin.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
import '../../core/utils/AppStrings.dart';
import '../../data/models/HomeNavigatorModel.dart';
import '../../l10n/app_localizations.dart';
import '../../view_models/HomeProvider.dart';
import '../../view_models/UserInfoProvider.dart';
import '../common_widgets/AppScaffold.dart';
import '../common_widgets/IconTextWidget.dart';
import '../dialogs/MembershipCancelledDialog.dart';
import '../dialogs/MyBenefitsDialog.dart';
import 'widgets/AllMenuItemsWidget.dart';
import 'widgets/HomeAppBar.dart';
import 'widgets/PointsBalanceWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with LoggingMixin, WidgetsBindingObserver {
  Timer? _pointsDialogTimer;
  late HomeProvider _homeProvider;
  late UserInfoProvider _userInfoProvider;
  late Flavor flavor;
  late AppLocalizations loc;
  bool isMembershipCancelledDialogShown = false;
  bool _isCustomTabOpening = false;

  final partnerOffersMissingApps = {
    Flavor.bluewater,
    Flavor.mhbc,
    Flavor.starReward,
    Flavor.queens,
    Flavor.brisbane,
    Flavor.hogansReward,
    Flavor.woollahra,
    Flavor.flinders,
    Flavor.aceRewards,
    Flavor.northShoreTavern,
    Flavor.kingscliff,
  };
  final partnerOffersAndPointsBalanceMissingApps = {
    Flavor.clh,
    Flavor.montaukTavern
  };

  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      WidgetsBinding.instance.addObserver(this);
      _userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
      _userInfoProvider.retrieveUserInfo();
      _userInfoProvider.runFetchProfileTimer();
      _userInfoProvider.uploadDeviceDetail();
      _userInfoProvider.checkForAppUpdate();
      _homeProvider = Provider.of<HomeProvider>(context, listen: false);
      _homeProvider.getAllOptionsTimer();

      flavor = FlavorConfig.instance.flavor!;
      logEvent("SELECTED FLAVOR $flavor");

      //checkForPushNotificationPermission();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies HOME");
  }

  startPointsDialogTimer() {
    _pointsDialogTimer = Timer(const Duration(seconds: 5), () {
      _homeProvider.updatePointsBalanceVisibility(false);
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
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _isCustomTabOpening = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    loc = AppLocalizations.of(context)!;
    return AppScaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Consumer2<HomeProvider, UserInfoProvider>(
              builder: (context, provider, userInfoProvider, child) {
            if (userInfoProvider.getUserInfo != null &&
                userInfoProvider.getUserInfo!.isUserStatusCancelled() &&
                !isMembershipCancelledDialogShown) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) return;
                // Ensure this route is current and the dialog hasn't already been shown
                if ((ModalRoute.of(context)?.isCurrent ?? false) &&
                    !isMembershipCancelledDialogShown) {
                  setState(() {
                    isMembershipCancelledDialogShown = true;
                  });
                  MembershipCancelledDialog.getInstance()
                      .showMembershipCancelledDialog(context);
                }
              });
            }

            if (userInfoProvider.getUserInfo != null &&
                provider.deeplinkPayloads != null) {
              if (provider.startChewzieScreen != null &&
                  provider.startChewzieScreen! &&
                  !_isCustomTabOpening) {
                _isCustomTabOpening = true;

                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  final decodedLink =
                      Uri.decodeComponent(provider.deeplinkPayloads!);

                  final uri = Uri.parse(decodedLink);

                  final jsonPayload = {
                    "memberId": "${userInfoProvider.getUserInfo!.cardNumber}",
                  };

                  final base64Payload =
                      base64UrlEncode(utf8.encode(jsonEncode(jsonPayload)));
                  final updatedUri = uri.replace(
                    queryParameters: {
                      ...uri.queryParameters, // keep existing params
                      'memberData': base64Payload, // add yours
                    },
                  );

                  await launchDeepLinkURL(updatedUri);
                  provider.resetDeepLinkNavigation();
                  _isCustomTabOpening = false;

                  /* AppNavigator.navigateTo(context, AppNavigator.appWebView,
                      arguments: updatedUri.toString());*/
                });

                /*Future.delayed(Duration.zero, () {
                  provider.resetDeepLinkNavigation();
                });*/
              }
            }

            return Column(
              children: [
                const HomeAppBar(),
                AppDimens.shape_20,
                Expanded(
                    child: Stack(
                  children: [
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
                        : const SizedBox.shrink(),
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
                            iconColor:
                                AppThemeCustom.getCustomHomeButtonsIconStyle(
                                    context,
                                    provider,
                                    userInfoProvider,
                                    provider.homeNavigationList[index].name),
                            text: provider
                                .getTranslatedOptionsName(loc,
                                    provider.homeNavigationList[index].name)
                                .replaceAll(" ", "\n")
                                .toUpperCase(),
                            textColor:
                                AppThemeCustom.getCustomHomeButtonsTextStyle(
                                    context,
                                    provider,
                                    userInfoProvider,
                                    provider.homeNavigationList[index].name),
                            margin: const EdgeInsets.all(5),
                            textSize: 13,
                            decoration: BoxDecoration(
                                color: (provider.selectedOption == index)
                                    ? Theme.of(context)
                                        .iconTheme
                                        .color!
                                        .withValues(alpha: 0.5)
                                    : Colors.transparent,
                                border: AppThemeCustom
                                    .getCustomHomeButtonsBorderStyle(
                                        context,
                                        provider,
                                        userInfoProvider,
                                        provider
                                            .homeNavigationList[index].name),
                                borderRadius: BorderRadius.circular(10)),
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
                              if (userInfoProvider.getUserInfo != null &&
                                  !userInfoProvider.getUserInfo!
                                      .isUserStatusCancelled()) {
                                /// HIDE POINTS BALANCE DIALOG
                                startPointsDialogTimer();
                              }
                            },
                            onTapDown: (value) {
                              if (userInfoProvider.getUserInfo != null &&
                                  !userInfoProvider.getUserInfo!
                                      .isUserStatusCancelled()) {
                                /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                                checkAndHideSeeAllOptionMenu(
                                    provider, "points balance");

                                final pointsBalanceOptionName =
                                    provider.homeNavigationList[0].name;
                                final partnerOffersOptionName =
                                    provider.homeNavigationList[2].name;
                                final selectedOptionName =
                                    provider.homeNavigationList[index].name;

                                if (partnerOffersMissingApps.contains(flavor) &&
                                    selectedOptionName ==
                                        partnerOffersOptionName) {
                                  /// DO NOTHING
                                } else if (partnerOffersAndPointsBalanceMissingApps
                                        .contains(flavor) &&
                                    (selectedOptionName ==
                                            pointsBalanceOptionName ||
                                        selectedOptionName ==
                                            partnerOffersOptionName)) {
                                  /// DO NOTHING
                                } else {
                                  provider.updateSelectedOption(index);

                                  if (provider.homeNavigationList[index].name ==
                                      provider.homeNavigationList[0].name) {
                                    /// SHOW POINTS BALANCE DIALOG
                                    provider
                                        .updatePointsBalanceVisibility(true);
                                  } else {
                                    /// HIDE & CHECK IF POINTS BALANCE MENU IS VISIBLE OR NOT
                                    checkAndHidePointsBalance(
                                        provider, "FROM TOP ROW");
                                  }
                                }

                                /*if (flavor == Flavor.bluewater &&
                                  provider.homeNavigationList[index].name ==
                                      provider.homeNavigationList[2].name) {
                                /// DO NOTHING ///
                              } else if (flavor == Flavor.mhbc &&
                                  provider.homeNavigationList[index].name ==
                                      provider.homeNavigationList[2].name) {
                                /// DO NOTHING ///
                              } else if ((flavor == Flavor.clh &&
                                      provider.homeNavigationList[index].name ==
                                          provider
                                              .homeNavigationList[0].name) ||
                                  (flavor == Flavor.clh &&
                                      provider.homeNavigationList[index].name ==
                                          provider
                                              .homeNavigationList[2].name)) {
                                /// DO NOTHING ///
                              } else if ((flavor == Flavor.montaukTavern &&
                                      provider.homeNavigationList[index].name ==
                                          provider
                                              .homeNavigationList[0].name) ||
                                  (flavor == Flavor.montaukTavern &&
                                      provider.homeNavigationList[index].name ==
                                          provider
                                              .homeNavigationList[2].name)) {
                                /// DO NOTHING ///
                              } else if ((flavor == Flavor.starReward &&
                                  provider.homeNavigationList[index].name ==
                                      provider.homeNavigationList[2].name)) {
                                /// DO NOTHING ///
                              } else if ((flavor == Flavor.queens &&
                                  provider.homeNavigationList[index].name ==
                                      provider.homeNavigationList[2].name)) {
                                /// DO NOTHING ///
                              } else if ((flavor == Flavor.brisbane &&
                                  provider.homeNavigationList[index].name ==
                                      provider.homeNavigationList[2].name)) {
                                /// DO NOTHING ///
                              } else if ((flavor == Flavor.hogansReward &&
                                  provider.homeNavigationList[index].name ==
                                      provider.homeNavigationList[2].name)) {
                                /// DO NOTHING ///
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
                              }*/
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
                            iconColor: (userInfoProvider.getUserInfo != null &&
                                    userInfoProvider.getUserInfo!
                                        .isUserStatusCancelled())
                                ? AppColors.disable_color
                                : null,
                            text: provider
                                .getTranslatedOptionsName(loc,
                                    provider.homeNavigationList[index + 3].name)
                                .replaceAll(" ", "\n")
                                .toUpperCase(),
                            margin: const EdgeInsets.all(5),
                            textSize: 13,
                            textColor: (userInfoProvider.getUserInfo != null &&
                                    userInfoProvider.getUserInfo!
                                        .isUserStatusCancelled())
                                ? AppColors.disable_color
                                : Theme.of(context)
                                    .textSelectionTheme
                                    .selectionColor,
                            decoration: BoxDecoration(
                                color: (userInfoProvider.getUserInfo != null &&
                                        userInfoProvider.getUserInfo!
                                            .isUserStatusCancelled())
                                    ? Colors.transparent
                                    : ((provider.selectedOption == index + 3)
                                        ? Theme.of(context)
                                            .iconTheme
                                            .color!
                                            .withValues(alpha: 0.5)
                                        : Colors.transparent),
                                border: Border.all(
                                    color:
                                        (userInfoProvider.getUserInfo != null &&
                                                userInfoProvider.getUserInfo!
                                                    .isUserStatusCancelled())
                                            ? AppColors.disable_color
                                            : Theme.of(context)
                                                .buttonTheme
                                                .colorScheme!
                                                .onSecondary,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            onClick: () {
                              if (userInfoProvider.getUserInfo != null &&
                                  !userInfoProvider.getUserInfo!
                                      .isUserStatusCancelled()) {
                                /// HIDE & CHECK IF POINTS BALANCE MENU IS VISIBLE OR NOT
                                checkAndHidePointsBalance(
                                    provider, "FROM SECOND ROW");

                                if (provider
                                        .homeNavigationList[index + 3].name !=
                                    provider.homeNavigationList[5].name) {
                                  /// HIDE & CHECK IF SEE ALL MENU IS VISIBLE OR NOT
                                  if (provider.showSeeAllMenu == true &&
                                      (provider.homeNavigationList[index + 3]
                                              .name !=
                                          provider
                                              .homeNavigationList[6].name)) {
                                    provider.updateShowAllMenuVisibility(
                                        false, "");
                                  }

                                  provider.updateSelectedOption(index + 3);
                                }

                                if (provider
                                        .homeNavigationList[index + 3].name ==
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
                                    provider.updateShowAllMenuVisibility(
                                        false, "SeeAllMenu");
                                  } else {
                                    /// SEE ALL DIALOG IS NOT VISIBLE WE NEED TO SHOW IT
                                    provider.updateShowAllMenuVisibility(
                                        true, "SeeAllMenu");
                                  }
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
    return (provider.showSeeAllMenu &&
            (provider.moreButtonsMap != null &&
                provider.moreButtonsMap!.isNotEmpty))
        ? const AllMenuItemsWidget()
        : const SizedBox.shrink();
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

  checkForSeeAllMenuVisibility(HomeProvider provider, int index) {
    return provider
                .getTranslatedOptionsName(
                    loc, provider.homeNavigationList[index + 3].name)
                .replaceAll(" ", "\n")
                .toUpperCase() ==
            provider
                .getTranslatedOptionsName(
                    loc, provider.homeNavigationList[6].name)
                .replaceAll(" ", "\n")
                .toUpperCase() &&
        (provider.moreButtonsMap == null || provider.moreButtonsMap!.isEmpty);
  }

  int i = 0;

  Future<void> launchDeepLinkURL(Uri uri) async {
    print("Called URI ${uri.toString()}");
    print("Launch Count ${i++}");
    await launchUrl(uri,
        customTabsOptions: CustomTabsOptions(
          showTitle: false,
          urlBarHidingEnabled: true,
          shareState: CustomTabsShareState.off,
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: Theme.of(context).primaryColor,
          ),
        ),
        safariVCOptions: SafariViewControllerOptions(
          barCollapsingEnabled: true,
          preferredBarTintColor: Theme.of(context).primaryColor,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ));
  }
}
