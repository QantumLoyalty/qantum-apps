import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qantum_apps/l10n/app_localizations.dart';
import '../core/mixins/logging_mixin.dart';
import '../core/utils/AppHelper.dart';
import '../data/models/MoreButtonModel.dart';
import '../data/models/NetworkResponse.dart';
import '../services/AppDataService.dart';
import '../core/utils/AppStrings.dart';
import '../data/models/HomeNavigatorModel.dart';
import '../views/my_venues/MyVenuesHomeScreen.dart';
import '../views/partners_offer/PartnerOffersScreen.dart';
import '../views/profile/MyProfileScreen.dart';
import '../views/special_offers/SpecialOffersScreen.dart';

class HomeProvider extends ChangeNotifier with LoggingMixin {
  Timer? _fetchSeeAllTimer;

  int _selectedOption = 3;

  int get selectedOption => _selectedOption;

  int _prevSelectedOption = 3;

  int get prevSelectedOption => _prevSelectedOption;

  Map<int, dynamic>? _moreButtonsMap;

  Map<int, dynamic>? get moreButtonsMap => _moreButtonsMap;

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
        icon: Icons.attach_money,
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
        icon: Icons.restaurant,
        type: HomeNavigatorModel.typeDialog),
    HomeNavigatorModel(
        name: "txtMyAccount",
        screen: const MyProfileScreen(),
        icon: Icons.account_circle_outlined,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: "txtSeeAll",
        screen: Container(),
        icon: Icons.more_horiz,
        type: HomeNavigatorModel.typeDialog),
  ];

  String getTranslatedOptionsName(AppLocalizations loc, String key) {
    switch (key) {
      case "txtPointsBalance":
        return loc.txtPointsBalance;
      case "txtSpecialOffers":
        return loc.txtSpecialOffers;
      case "txtPartnerOffers":
        return loc.txtPartnerOffers;
      case "txtMyVenue":
        return loc.txtMyVenue;
      case "txtMyBenefits":
        return loc.txtMyBenefits;
      case "txtMyAccount":
        return loc.txtMyAccount;
      case "txtSeeAll":
        return loc.txtSeeAll;
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
            logEvent(_moreButtonsMap);
          }
        }
      }

      logEvent(networkResponse);
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
    _deeplinkPayloads = null;
    _startChewzieScreen = null;
    notifyListeners();
  }
}
