import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:condition_builder/condition_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/views/common_widgets/OurGuaranteeWidget.dart';
import 'package:qantum_apps/views/dialogs/OurGuaranteeDialog.dart';
import '/core/enums/FetchProfileState.dart';
import '/core/enums/MembershipStatus.dart';
import '/core/extensions/log_extension.dart';
import '/core/extensions/spacer_extension.dart';
import '/core/utils/AppDateFormatter.dart';
import '/core/utils/AppHelper.dart';
import '/data/local/SharedPreferenceHelper.dart';
import '/views/dialogs/EarlyRenewalMembershipDialog.dart';
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
    Flavor.edp
  };
  final partnerOffersAndPointsBalanceMissingApps = {
    Flavor.clh,
    Flavor.montaukTavern,
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
  String? _lastHandledChewziePayload;
  DateTime? _lastHandledChewzieTime;
 /* void _tryOpenDeepLink(
    HomeProvider provider,
    UserInfoProvider userInfoProvider,
  ) {
    print(
        "_deepLinkHandled >> $_deepLinkHandled, provider.deeplinkPayloads >> ${provider.deeplinkPayloads} userInfoProvider.getUserInfo >> ${userInfoProvider.getUserInfo}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_deepLinkHandled || !mounted) return;

      if (provider.deeplinkPayloads == null) return;

      if (flavor == Flavor.starReward) {
        _handleChewzie(provider, userInfoProvider);
      }

      if (userInfoProvider.getUserInfo == null) return;

      if (flavor == Flavor.mhbc) {
        _handleClevaQ(provider, userInfoProvider);
      }
    });
  }*/

  /*void _handleChewzie(
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
  }*/

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
            // _tryOpenDeepLink(provider, userInfoProvider);

            _scheduleDeepLinkHandling();

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
                    membershipExpiry: provider
                        .selectedMembership!.expiryEarlyBirdRenewalDate!)) {
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
                        ?  flavor==Flavor.bobsBulkBooze?SizedBox.shrink():PointsBalanceWidget()
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
                            iconColor: AppThemeCustom.getHomeButtonsIconColor(
                              context,
                              provider,
                              userInfoProvider,
                              provider.homeNavigationList[index].name,
                              provider.selectedOption == index,
                            ),
                            text: provider
                                .getTranslatedOptionsName(
                                  loc,
                                  provider.homeNavigationList[index].name,
                                  flavor: flavor,
                                )
                                .replaceAll(" ", "\n")
                                .toUpperCase(),
                            textColor: AppThemeCustom.getHomeButtonsTextColor(
                              context,
                              provider,
                              userInfoProvider,
                              provider.homeNavigationList[index].name,
                              provider.selectedOption == index,
                            ),
                            margin: const EdgeInsets.all(5),
                            textSize: 13,
                            decoration: BoxDecoration(
                                color: AppThemeCustom
                                    .getHomeButtonsBackgroundColor(
                                  context,
                                  provider,
                                  index,
                                  provider.selectedOption == index,
                                ),
                                border: AppThemeCustom.getHomeButtonsBorder(
                                  context,
                                  provider,
                                  userInfoProvider,
                                  provider.homeNavigationList[index].name,
                                  provider.selectedOption == index,
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
                                    if (flavor == Flavor.bobsBulkBooze) {

                                      /// SHOW OUR GUARANTEE DIALOG
                                      OurGuaranteeDialog.getInstance()
                                          .showGuaranteeDialog(context);

                                    } else {

                                      /// SHOW POINTS BALANCE DIALOG
                                      provider.updatePointsBalanceVisibility(true);
                                    }
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
                            iconColor: AppThemeCustom.getHomeButtonsIconColor(
                                context,
                                provider,
                                userInfoProvider,
                                provider.homeNavigationList[index + 3].name,
                                provider.selectedOption == index + 3),
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
                            textColor: AppThemeCustom.getHomeButtonsTextColor(
                              context,
                              provider,
                              userInfoProvider,
                              provider.homeNavigationList[index + 3].name,
                              provider.selectedOption == index + 3,
                            ),
                            decoration: BoxDecoration(
                                color: AppThemeCustom
                                    .getHomeButtonsBackgroundColor(
                                  context,
                                  provider,
                                  index,
                                  provider.selectedOption == index + 3,
                                ),
                                border: AppThemeCustom.getHomeButtonsBorder(
                                  context,
                                  provider,
                                  userInfoProvider,
                                  provider.homeNavigationList[index + 3].name,
                                  provider.selectedOption == index + 3,
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

  bool _deepLinkCheckScheduled = false;
  Uri? _pendingDeepLinkUri;
  bool _isLaunchingDeepLink = false;
  AppLifecycleState _appLifecycleState = AppLifecycleState.resumed;
  DateTime? _lastLaunchTime;
  String? _lastLaunchPayload;

  void _scheduleDeepLinkHandling() {
    if (_deepLinkCheckScheduled || !mounted) return;
    _deepLinkCheckScheduled = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _deepLinkCheckScheduled = false;
      if (!mounted) return;

      final provider = context.read<HomeProvider>();
      final userInfoProvider = context.read<UserInfoProvider>();

      if (provider.deeplinkPayloads == null) return;


      if (flavor == Flavor.starReward) {

        _prepareChewzie(provider, userInfoProvider);
        return;
      }

      if (userInfoProvider.getUserInfo == null) return;

      if (flavor == Flavor.mhbc) {
        _prepareClevaQ(provider, userInfoProvider);
      }
    });
  }

  void _prepareChewzie(
    HomeProvider provider,
    UserInfoProvider userInfoProvider,
  ) async {
    final payload = provider.deeplinkPayloads;
    if (payload == null || payload.isEmpty) return;
    if (provider.startChewzieScreen != true) return;

    if (_isDuplicateChewzieLaunch(payload)) {
      provider.resetDeepLinkNavigation();
      return;
    }

    _lastHandledChewziePayload = payload;
    _lastHandledChewzieTime = DateTime.now();

    provider.resetDeepLinkNavigation();



    final decodedLink = Uri.decodeComponent(payload);
    final uri = Uri.parse(decodedLink);

    try {
      final userInfo = userInfoProvider.getUserInfo ??
          await _waitForUserInfo(userInfoProvider)
          .timeout(const Duration(seconds: 10));
   //  final userInfo = userInfoProvider.getUserInfo;
      final cardNumber = userInfo!.cardNumber;

      if (cardNumber == null || cardNumber.isEmpty) {
        _handlePreparedDeepLink(uri);
        return;
      }

      final jsonPayload = {
        "memberId": cardNumber,
      };

      final base64Payload = base64UrlEncode(
        utf8.encode(jsonEncode(jsonPayload)),
      );

      final updatedUri = uri.replace(
        queryParameters: {
          ...uri.queryParameters,
          'memberData': base64Payload,
        },
      );

      _handlePreparedDeepLink(updatedUri);
    } catch (e) {
      debugPrint("Chewzie userInfo timeout/failure, opening without card: $e");
      _handlePreparedDeepLink(uri);
    }


/*
    final jsonPayload = {
      "memberId": userInfoProvider.getUserInfo!.cardNumber,
    };

    final base64Payload = base64UrlEncode(
      utf8.encode(jsonEncode(jsonPayload)),
    );

    final updatedUri = uri.replace(
      queryParameters: {
        ...uri.queryParameters,
        'memberData': base64Payload,
      },
    );

    _lastLaunchPayload = payload;
    _lastLaunchTime = now;

    provider.resetDeepLinkNavigation();
    _handlePreparedDeepLink(updatedUri);

*/




  }

  bool _isDuplicateChewzieLaunch(String payload) {
    final now = DateTime.now();

    return _lastHandledChewziePayload == payload &&
        _lastHandledChewzieTime != null &&
        now.difference(_lastHandledChewzieTime!) < const Duration(seconds: 3);
  }

  Future<dynamic> _waitForUserInfo(UserInfoProvider provider) async {
    while (mounted) {
      if (provider.getUserInfo != null) {
        return provider.getUserInfo;
      }

      await Future.delayed(const Duration(milliseconds: 200));
    }

    throw Exception("HomeScreen unmounted before user info loaded");
  }

  void _prepareClevaQ(
    HomeProvider provider,
    UserInfoProvider userInfoProvider,
  ) {
    final payload = provider.deeplinkPayloads;
    if (payload == null || payload.isEmpty) return;

    final now = DateTime.now();
    if (_lastLaunchPayload == payload &&
        _lastLaunchTime != null &&
        now.difference(_lastLaunchTime!) < const Duration(seconds: 2)) {
      provider.resetDeepLinkNavigation();
      return;
    }

    final uri = Uri.parse(payload);

    final updatedUri = uri.replace(
      pathSegments: [
        ...uri.pathSegments,
        'qantumMember',
        userInfoProvider.getUserInfo?.cardNumber ?? "",
        AppDateFormatter.dobForClevaQ(
              userInfoProvider.getUserInfo?.dateOfBirth,
            ) ??
            "",
      ],
    );

    _lastLaunchPayload = payload;
    _lastLaunchTime = now;

    provider.resetDeepLinkNavigation();
    _handlePreparedDeepLink(updatedUri);
  }

  void _handlePreparedDeepLink(Uri uri) {
    if (Platform.isIOS) {
      _pendingDeepLinkUri = uri;
      _tryLaunchPendingDeepLink();
    } else {
      _launchNow(uri);
    }
  }

  Future<void> _launchNow(Uri uri) async {
    if (_isLaunchingDeepLink) return;

    _isLaunchingDeepLink = true;
    try {
      await launchDeepLinkURL(uri);
    } catch (e, st) {
      debugPrint("Direct launch failed: $e");
      debugPrintStack(stackTrace: st);
    } finally {
      _isLaunchingDeepLink = false;
    }
  }

  Future<void> _tryLaunchPendingDeepLink() async {
    final uri = _pendingDeepLinkUri;
    if (uri == null) return;
    if (_isLaunchingDeepLink) return;
    if (!mounted) return;

    final routeIsCurrent = ModalRoute.of(context)?.isCurrent ?? false;
    final appIsResumed = _appLifecycleState == AppLifecycleState.resumed;

    if (!routeIsCurrent || !appIsResumed) return;

    _isLaunchingDeepLink = true;

    try {
      await Future.delayed(const Duration(milliseconds: 400));
      await launchDeepLinkURL(uri);
      _pendingDeepLinkUri = null;
    } finally {
      _isLaunchingDeepLink = false;
    }
  }

  Future<void> launchDeepLinkURL(Uri uri) async {
    try {
      debugPrint("Launching deep link URL: $uri");

      if (Platform.isIOS) {
        try {
          await closeCustomTabs();
          await Future.delayed(const Duration(milliseconds: 250));
        } catch (_) {
          // ignore; there may be nothing open
        }
      }

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
    } catch (e) {
      e.toString().logMessage("LAUNCH URL EXCEPTION");
    }
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
