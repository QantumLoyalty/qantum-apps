import 'dart:async';
import 'dart:convert';

import 'package:condition_builder/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/enums/FetchProfileState.dart';
import 'package:qantum_apps/core/enums/MembershipStatus.dart';
import 'package:qantum_apps/core/extensions/spacer_extension.dart';
import 'package:qantum_apps/core/utils/AppDateFormatter.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/data/local/SharedPreferenceHelper.dart';
import 'package:qantum_apps/views/dialogs/EarlyRenewalMembershipDialog.dart';

import '../../core/flavors_config/app_theme_custom.dart';
import '../../core/flavors_config/flavor_config.dart';
import '../../core/mixins/logging_mixin.dart';
import '../../core/navigation/AppNavigator.dart';
import '../../core/utils/AppColors.dart';
import '../../core/utils/AppDimens.dart';
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

  final partnerOffersMissingApps = {
    Flavor.bluewater,
    Flavor.mhbc,
    Flavor.queens,
    Flavor.brisbane,
    Flavor.hogansReward,
    Flavor.woollahra,
    Flavor.flinders,
    Flavor.aceRewards,
    Flavor.northShoreTavern,
    Flavor.kingscliff,
    Flavor.drinkRewards,
    Flavor.wonthaggi,
    Flavor.edp,
  };
  final partnerOffersAndPointsBalanceMissingApps = {
    Flavor.clh,
    Flavor.montaukTavern
  };

  bool _hasRedirectedToMembershipBuy = false;

  @override
  void initState() {
    super.initState();
    if (context.mounted) {
      WidgetsBinding.instance.addObserver(this);
      _userInfoProvider = Provider.of<UserInfoProvider>(context, listen: false);
      _userInfoProvider.retrieveUserInfo();
      _userInfoProvider.runFetchProfileTimer(fetchFromBluize: "false");
      _userInfoProvider.uploadDeviceDetail();
      _userInfoProvider.checkForAppUpdate();
      _homeProvider = Provider.of<HomeProvider>(context, listen: false);
      _homeProvider.getAllOptionsTimer();
      flavor = FlavorConfig.instance.flavor!;
      logEvent("SELECTED FLAVOR $flavor");
    }
  }

  bool _deepLinkHandled = false;

  void _tryOpenDeepLink(
    HomeProvider provider,
    UserInfoProvider userInfoProvider,
  ) {
    if (_deepLinkHandled) return;

    if (provider.deeplinkPayloads == null) return;
    if (userInfoProvider.getUserInfo == null) return;

    if (flavor == Flavor.starReward) {
      _handleChewzie(provider, userInfoProvider);
    } else if (flavor == Flavor.mhbc) {
      _handleClevaQ(provider, userInfoProvider);
    }
  }

  void _handleChewzie(
      HomeProvider provider, UserInfoProvider userInfoProvider) {
    if (provider.startChewzieScreen != true) return;

    _deepLinkHandled = true;

    final decodedLink = Uri.decodeComponent(provider.deeplinkPayloads!);
    final uri = Uri.parse(decodedLink);

    final jsonPayload = {
      "memberId": userInfoProvider.getUserInfo!.cardNumber,
    };

    final base64Payload = base64UrlEncode(utf8.encode(jsonEncode(jsonPayload)));

    final updatedUri = uri.replace(
      queryParameters: {
        ...uri.queryParameters,
        'memberData': base64Payload,
      },
    );

    launchDeepLinkURL(updatedUri);
    provider.resetDeepLinkNavigation();
  }

  void _handleClevaQ(HomeProvider provider, UserInfoProvider userInfoProvider) {
    _deepLinkHandled = true;

    final uri = Uri.parse(provider.deeplinkPayloads!);
    final updatedUri = uri.replace(pathSegments: [
      ...uri.pathSegments,
      'qantumMember',
      userInfoProvider.getUserInfo!.cardNumber ?? "",
      AppDateFormatter.dobForClevaQ(
              userInfoProvider.getUserInfo!.dateOfBirth) ??
          ""
    ]);
    print("DEEPLINK URL: ${updatedUri.toString()}");
    launchDeepLinkURL(updatedUri);
    provider.resetDeepLinkNavigation();
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
            _tryOpenDeepLink(provider, userInfoProvider);

            if (userInfoProvider.getUserInfo != null) {
              if ((userInfoProvider.membershipStatus ==
                      MembershipStatus.inactive) &&
                  !_hasRedirectedToMembershipBuy &&
                  userInfoProvider.fetchProfileState ==
                      FetchProfileState.loaded) {
                _hasRedirectedToMembershipBuy = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppNavigator.navigateReplacement(
                      context, AppNavigator.renewMembershipScreen);
                });
              }
            }

            /// CHECKING & GETTING THE USER MEMBERSHIP PLAN
            if (userInfoProvider.getUserInfo != null &&
                AppHelper.isClubApp() &&
                !provider.clubPackageCheckStatus) {
              provider.getClubPackageInfo(
                  membershipID: userInfoProvider.getUserInfo!.packageId);

              // provider.resetClubPackageCheckStatus();
            }

            /// CHECKING FOR THE EARLY BIRD DIALOG
            if (userInfoProvider.getUserInfo != null &&
                !provider.checkEarlyBirdCondition &&
                provider.selectedMembership != null) {
//              _showEarlyBirdDialogIfNeeded();

              logEvent(
                  "ENTERED IN \"CHECKING FOR THE EARLY BIRD DIALOG BLOCK\"");
              if (provider.selectedMembership!.earlyBirdPeriod != null &&
                  provider.selectedMembership!.earlyBirdRenewalDate != null &&
                  provider
                      .selectedMembership!.earlyBirdRenewalDate!.isNotEmpty) {
                /// CHECKING IF USER HAS ALREADY BOUGHT THE MEMBERSHIP
                if (!AppDateFormatter.ifUserPurchasedMembership(
                    usersMembershipExpiry:
                        userInfoProvider.getUserInfo!.membershipExpiryDate!,
                    membershipExpiry:
                        provider.selectedMembership!.renewalDate!)) {
                  logEvent(
                      "ENTERED IN \"CHECKING IF USER HAS ALREADY BOUGHT THE MEMBERSHIP\"");

                  /// CHECKING IF CURRENT DAY IS FALLING UNDER EARLY BIRD DATE RANGE

                  if (AppDateFormatter.isCurrentDateUnderEarlyBirdRange(
                      earlyBirdPeriod:
                          provider.selectedMembership!.earlyBirdPeriod!)) {
                    logEvent(
                        "ENTERED IN \"CHECKING CURRENT DAY FALLING UNDER EARLY BIRD DATE RANGE\"");
                    _showEarlyBirdDialogIfNeeded();
                  }
                }
              }

              provider.resetCheckEarlyBirdCondition();
            }

            return Column(
              children: [
                const HomeAppBar(),
                // AppDimens.shape_20,

                20.h,
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
                            iconColor: provider.selectedOption == index &&
                                (flavor == Flavor.senseOfTaste ||
                                    flavor == Flavor.bobsBulkBooze)
                                ? provider.homeNavigationList[2].name ==
                                provider.homeNavigationList[index].name
                                ? AppColors.transparent
                                : AppColors.white
                                : AppThemeCustom.getCustomHomeButtonsIconStyle(
                                    context,
                                    provider,
                                    userInfoProvider,
                                    provider.homeNavigationList[index].name),
                            text: provider
                                .getTranslatedOptionsName(
                                  loc,
                                  provider.homeNavigationList[index].name,
                                  flavor: flavor,
                                )
                                .replaceAll(" ", "\n")
                                .toUpperCase(),
                            textColor: provider.selectedOption == index &&
                                    (flavor == Flavor.senseOfTaste ||
                                        flavor == Flavor.bobsBulkBooze)
                                ? provider.homeNavigationList[2].name ==
                                        provider.homeNavigationList[index].name
                                    ? AppColors.transparent
                                    : AppColors.white
                                : AppThemeCustom.getCustomHomeButtonsTextStyle(
                                    context,
                                    provider,
                                    userInfoProvider,
                                    provider.homeNavigationList[index].name),
                            margin: const EdgeInsets.all(5),
                            textSize: 13,
                            decoration: BoxDecoration(
                                color: (provider.selectedOption == index)
                                    ? (flavor == Flavor.senseOfTaste ||
                                            flavor == Flavor.bobsBulkBooze)
                                        ? provider.homeNavigationList[2].name ==
                                                provider
                                                    .homeNavigationList[index]
                                                    .name
                                            ? null
                                            : AppColors.button_shadow
                                        : Theme.of(context)
                                            .iconTheme
                                            .color!
                                            .withValues(alpha: 0.5)
                                    : Colors.transparent,
                                border: provider.selectedOption == index &&
                                        (flavor == Flavor.senseOfTaste ||
                                            flavor == Flavor.bobsBulkBooze)
                                    ? provider.homeNavigationList[2].name ==
                                            provider
                                                .homeNavigationList[index].name
                                        ? null
                                        : Border.all(color: AppColors.white)
                                    : AppThemeCustom
                                        .getCustomHomeButtonsBorderStyle(
                                        context,
                                        provider,
                                        userInfoProvider,
                                        provider.homeNavigationList[index].name,
                                      ),
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
                              print("Tap down called for index $index");

                              if (userInfoProvider.getUserInfo != null &&
                                  !userInfoProvider.getUserInfo!
                                      .isUserStatusCancelled()) {
                                print("Entered in if block for index $index");

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
                              } else {
                                print("issue in user status");
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
                            iconColor: provider.selectedOption == index + 3 &&
                                    (flavor == Flavor.senseOfTaste ||
                                        flavor == Flavor.bobsBulkBooze)
                                ? AppColors.white
                                : AppThemeCustom.getCustomHomeButtonsIconStyle(
                                    context,
                                    provider,
                                    userInfoProvider,
                                    provider
                                        .homeNavigationList[index + 3].name),
                            text: provider
                                .getTranslatedOptionsName(
                                  loc,
                                  provider.homeNavigationList[index + 3].name,
                                  flavor: flavor,
                                )
                                .replaceAll(" ", "\n")
                                .toUpperCase(),
                            margin: const EdgeInsets.all(5),
                            textSize: 13,
                            textColor: provider.selectedOption == index + 3 &&
                                    (flavor == Flavor.senseOfTaste ||
                                        flavor == Flavor.bobsBulkBooze)
                                ? AppColors.white
                                : AppThemeCustom.getCustomHomeButtonsTextStyle(
                                    context,
                                    provider,
                                    userInfoProvider,
                                    provider
                                        .homeNavigationList[index + 3].name),
                            decoration: BoxDecoration(
                                color: provider.selectedOption == index + 3 &&
                                        (flavor == Flavor.senseOfTaste ||
                                            flavor == Flavor.bobsBulkBooze)
                                    ? AppColors.button_shadow
                                    : (userInfoProvider.getUserInfo != null &&
                                            userInfoProvider.getUserInfo!
                                                .isUserStatusCancelled())
                                        ? Colors.transparent
                                        : ((provider.selectedOption ==
                                                index + 3)
                                            ? Theme.of(context)
                                                .iconTheme
                                                .color!
                                                .withValues(alpha: 0.5)
                                            : Colors.transparent),
                                border: provider.selectedOption == index + 3 &&
                                        (flavor == Flavor.senseOfTaste ||
                                            flavor == Flavor.bobsBulkBooze)
                                    ? Border.all(color: AppColors.white)
                                    : AppThemeCustom
                                        .getCustomHomeButtonsBorderStyle(
                                        context,
                                        provider,
                                        userInfoProvider,
                                        provider
                                            .homeNavigationList[index + 3].name,
                                      ),
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
                  loc,
                  provider.homeNavigationList[index + 3].name,
                  flavor: flavor,
                )
                .replaceAll(" ", "\n")
                .toUpperCase() ==
            provider
                .getTranslatedOptionsName(
                  loc,
                  provider.homeNavigationList[6].name,
                  flavor: flavor,
                )
                .replaceAll(" ", "\n")
                .toUpperCase() &&
        (provider.moreButtonsMap == null || provider.moreButtonsMap!.isEmpty);
  }

  Future<void> launchDeepLinkURL(Uri uri) async {
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

  _showEarlyBirdDialogIfNeeded() async {
    final prefs = await SharedPreferenceHelper.getInstance();
    final lastShownDate = prefs.getLastEarlyBirdDialogDate();
    final today = AppDateFormatter.formatDateForEarlyBird(DateTime.now());
    logEvent("lastShownDate >> $lastShownDate");
    if (lastShownDate != today) {
      await EarlyRenewalMembershipDialog.getInstance()
          .showRenewalMembershipDialog(
              context: context,
              currentMembership: _homeProvider.selectedMembership!);
      await prefs.saveLastEarlyBirdDialogDate(today!);
    }
  }
}
