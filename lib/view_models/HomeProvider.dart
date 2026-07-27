import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qantum_apps/core/extensions/log_extension.dart';
import 'package:qantum_apps/core/flavors_config/flavor_config.dart';
import 'package:qantum_apps/data/models/MembershipModel.dart';
import 'package:qantum_apps/data/models/notification_model.dart';
import 'package:qantum_apps/l10n/app_localizations.dart';
import 'package:qantum_apps/services/notification_services.dart';
import '../core/mixins/logging_mixin.dart';
import '../core/utils/AppHelper.dart';
import '../data/models/MoreButtonModel.dart';
import '../data/models/NetworkResponse.dart';
import '../services/AppDataService.dart';
import '../core/utils/AppStrings.dart';
import '../data/models/HomeNavigatorModel.dart';
import '../views/my_venues/MyVenuesHomeScreen.dart';
import '../views/partners_offer/PartnerOffersScreen.dart';
import '../views/special_offers/SpecialOffersScreen.dart';

class HomeProvider extends ChangeNotifier with LoggingMixin {
  Timer? _fetchSeeAllTimer;

  int _selectedOption = 3;

  int get selectedOption => _selectedOption;

  int _prevSelectedOption = 3;

  int get prevSelectedOption => _prevSelectedOption;

  Map<int, dynamic>? _moreButtonsMap;

  Map<int, dynamic>? get moreButtonsMap => _moreButtonsMap;

  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  String? _notificationUserId;
  bool _hiveListenerAttached = false;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;


  void loadNotifications(String userId) {
    _notificationUserId = userId;
    _notifications = NotificationHiveService.getForUser(userId);
    _attachHiveListener();   // 👈 NAYI LINE
    notifyListeners();
  }

  void _attachHiveListener() {
    if (_hiveListenerAttached) return;
    _hiveListenerAttached = true;
    print('[HomeProvider] attaching Hive listener');   // 👈 ADD KARO
    NotificationHiveService.listenable.addListener(_onHiveBoxChanged);
  }

  void _onHiveBoxChanged() {
    print('[HomeProvider] Hive box changed - refreshing notifications');   // 👈 ADD KARO
    if (_notificationUserId == null) return;
    _notifications = NotificationHiveService.getForUser(_notificationUserId!);
    notifyListeners();
  }


  Future<void> refreshNotifications() async {
    if (_notificationUserId == null) return;
    _notifications = NotificationHiveService.getForUser(_notificationUserId!);
    notifyListeners();
  }

  Future<void> deleteNotification(NotificationModel n) async {
    _notifications.removeWhere((item) => item.id == n.id);
    notifyListeners();
    await NotificationHiveService.delete(n.id);
  }

  Future<void> onTapNotification(NotificationModel n) async {
    if (n.isRead) return;
    await NotificationHiveService.markAsRead(
      id: n.id,
      userId: n.userId,
      title: n.title,
      body: n.body,
      imageUrl: n.imageUrl,
      payload: n.payload,
    );
    await refreshNotifications();
  }

  updateSelectedOption(int value) {
    if (_homeNavigationList[_selectedOption].type ==
        HomeNavigatorModel.typeScreen) {
      _prevSelectedOption = _selectedOption;
    }
    _selectedOption = value;
    notifyListeners();
  }

  final List<HomeNavigatorModel> _homeNavigationList = [
    HomeNavigatorModel(
        name: "txtPointsBalance",
        screen: Container(),
        icon: FlavorConfig.instance.flavor == Flavor.bobsBulkBooze
            ? Icons.check
            : Icons.attach_money,
        type: HomeNavigatorModel.typeDialog),
    HomeNavigatorModel(
        name: "txtSpecialOffers",
        screen: const SpecialOffersScreen(),
        icon: Icons.card_giftcard,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: "txtPartnerOffers",
        screen: PartnerOffersScreen(),
        icon: Icons.handshake,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: "txtMyVenue",
        screen: const MyVenuesHomeScreen(),
        icon: Icons.location_on,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: "txtMyBenefits",
        screen: Container(),
        icon: FlavorConfig.instance.flavor == Flavor.bobsBulkBooze
            ? Icons.attach_money
            : Icons.restaurant,
        type: HomeNavigatorModel.typeDialog),
    HomeNavigatorModel(
        name: "txtMyAccount",
        screen: Container(),
        icon: Icons.account_circle_outlined,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: "txtMore",
        screen: Container(),
        icon: Icons.more_horiz,
        type: HomeNavigatorModel.typeDialog),
  ];

  String getTranslatedOptionsName(
    AppLocalizations loc,
    String key, {
    Flavor? flavor,
  }) {
    switch (key) {
      case "txtPointsBalance":
        if (flavor == Flavor.bobsBulkBooze) {
          return loc.txtOurGuarantee;
        }
        return loc.txtPointsBalance;
      case "txtSpecialOffers":
        return loc.txtSpecialOffers;
      case "txtPartnerOffers":
        return loc.txtPartnerOffers;
      case "txtMyVenue":
        return loc.txtMyVenue;
      case "txtMyBenefits":
        if (flavor == Flavor.bobsBulkBooze) {
          return loc.txtCurrentDeals;
        }
        return loc.txtMyBenefits;
      case "txtMyAccount":
        return loc.txtMyAccount;
      case "txtMore":
        return loc.txtMore;
      default:
        return key;
    }
  }

  List<HomeNavigatorModel> get homeNavigationList => _homeNavigationList;
  final List<HomeNavigatorModel> _seeAllOptionsList = [
    HomeNavigatorModel(
        name: AppStrings.txtBookRestaurant,
        screen: Container(),
        icon: Icons.restaurant_menu_rounded,
        type: HomeNavigatorModel.typeDialog),
    HomeNavigatorModel(
        name: AppStrings.txtBusTimetable,
        screen: Container(),
        icon: Icons.directions_bus_filled_outlined,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: AppStrings.txtShowTickets,
        screen: Container(),
        icon: Icons.airplane_ticket,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: AppStrings.txtPlaceHolder,
        screen: Container(),
        icon: Icons.location_on,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: AppStrings.txtPlaceHolder,
        screen: Container(),
        icon: Icons.location_on,
        type: HomeNavigatorModel.typeDialog),
    HomeNavigatorModel(
        name: AppStrings.txtPlaceHolder,
        screen: Container(),
        icon: Icons.location_on,
        type: HomeNavigatorModel.typeScreen),
  ];

  List<HomeNavigatorModel> get homeSeeAllOptionsList => _seeAllOptionsList;

  Widget get selectedScreen => _homeNavigationList[_selectedOption].screen;

  openMyProfileScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedOption = -1;
      notifyListeners();
    });
  }

  openMyDigitalCardScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedOption = -2;
      notifyListeners();
    });
  }

  bool _showPointsBalance = false;

  updatePointsBalanceVisibility(bool value) {
    _showPointsBalance = value;
    notifyListeners();
  }

  bool get showPointsBalance => _showPointsBalance;

  bool _showSeeAllMenu = false;

  updateShowAllMenuVisibility(bool value, String from) {
    _showSeeAllMenu = value;
    logEvent("from --> $from _showSeeAllMenu --> $_showSeeAllMenu");
    notifyListeners();
  }

  bool get showSeeAllMenu => _showSeeAllMenu;

  getAllOptions() async {
    try {
      NetworkResponse networkResponse =
          await AppDataService.getInstance().fetchSeeAllButtons();

      if (!networkResponse.isError && networkResponse.response != null) {
        Map<String, dynamic> response =
            networkResponse.response as Map<String, dynamic>;
        if (response["success"] as bool && response.containsKey("data")) {
          List<MoreButtonModel> moreButtonsList = [];
          (response["data"] as Map<String, dynamic>)["buttons"]
              .forEach((value) {
            moreButtonsList.add(MoreButtonModel.fromJson(value));
          });
          if (moreButtonsList.isNotEmpty) {
            _moreButtonsMap = {};
            for (int i = 1; i <= 6; i++) {
              List<MoreButtonModel> filterList = moreButtonsList
                  .where((item) => item.position == (i))
                  .toList();
              if (filterList.isNotEmpty) {
                _moreButtonsMap![i] = filterList[0];
              } else {
                _moreButtonsMap![i] = null;
              }
            }
          }

          if (_moreButtonsMap != null && _moreButtonsMap!.isNotEmpty) {
            if ((_moreButtonsMap![4] is! MoreButtonModel) &&
                (_moreButtonsMap![5] is! MoreButtonModel) &&
                (_moreButtonsMap![6] is! MoreButtonModel)) {
              _moreButtonsMap!.remove(4);
              _moreButtonsMap!.remove(5);
              _moreButtonsMap!.remove(6);
            }
          }
        }
      }
    } catch (e) {
      logEvent(e.toString());
    } finally {
      notifyListeners();
    }
  }

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  getAllOptionsTimer() async {
    await getAllOptions();
    _fetchSeeAllTimer = Timer.periodic(
        Duration(seconds: AppHelper.defaultRequestTime), (value) async {
      if (!_isFetching) {
        _isFetching = true;
        await getAllOptions();
        _isFetching = false;
      }
    });
  }

  stopGetAllOptionsTimer() {
    logEvent(
        "Fetch See All Timer Status::${_fetchSeeAllTimer != null && _fetchSeeAllTimer!.isActive}");
    if (_fetchSeeAllTimer != null && _fetchSeeAllTimer!.isActive) {
      _fetchSeeAllTimer!.cancel();
      _fetchSeeAllTimer = null;
    }
  }

  String? _deeplinkPayloads;

  String? get deeplinkPayloads => _deeplinkPayloads;
  bool? _startChewzieScreen;

  bool? get startChewzieScreen => _startChewzieScreen;

  setDeepLinkParams(String data) {
    _deeplinkPayloads = data;
    _startChewzieScreen = true;
    notifyListeners();
  }

  resetDeepLinkNavigation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _deeplinkPayloads = null;
      _startChewzieScreen = null;
      notifyListeners();
    });
  }

  String? consumeChewzieLink() {
    final link = _deeplinkPayloads;

    _deeplinkPayloads = null;
    _startChewzieScreen = false;
    notifyListeners();

    return link;
  }

  bool clubPackageCheckStatus = false;
  MembershipModel? _selectedMembership;

  MembershipModel? get selectedMembership => _selectedMembership;
  bool checkEarlyBirdCondition = false;

  getClubPackageInfo({String? membershipID}) async {
    if (membershipID == null) return;

    clubPackageCheckStatus = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      NetworkResponse networkResponse = await AppDataService.getInstance()
          .getMembershipPlansById(membershipID: membershipID!);
      ("GET PACKAGE INFO:  $networkResponse").logMessage();

      if (!networkResponse.isError && networkResponse.response != null) {
        Map<String, dynamic> response =
            networkResponse.response as Map<String, dynamic>;
        if (response["success"] as bool && response.containsKey("data")) {
          _selectedMembership = MembershipModel.fromJson(
              (response["data"] as Map<String, dynamic>));

          logEvent('SELECTED PACKAGE:: ${_selectedMembership.toString()}');
        }
      }
    } catch (e) {
      logEvent("getClubPackageInfo: ${e.toString()}");
    } finally {
      // clubPackageCheckStatus = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  resetClubPackageCheckStatus() {
    clubPackageCheckStatus = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  resetCheckEarlyBirdCondition() {
    checkEarlyBirdCondition = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
