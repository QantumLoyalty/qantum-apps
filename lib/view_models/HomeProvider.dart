import 'package:flutter/material.dart';
import '../core/utils/AppStrings.dart';
import '../data/models/HomeNavigatorModel.dart';
import '../views/my_venues/MyVenuesHomeScreen.dart';
import '../views/partners_offer/PartnerOffersScreen.dart';
import '../views/profile/MyProfileScreen.dart';
import '../views/special_offers/SpecialOffersScreen.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedOption = 3;

  int get selectedOption => _selectedOption;

  int _prevSelectedOption = 3;

  int get prevSelectedOption => _prevSelectedOption;

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
        name: AppStrings.txtPointsBalance,
        screen: Container(),
        icon: Icons.attach_money,
        type: HomeNavigatorModel.typeDialog),
    HomeNavigatorModel(
        name: AppStrings.txtSpecialOffers,
        screen: const SpecialOffersScreen(),
        icon: Icons.card_giftcard,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: AppStrings.txtPartnerOffers,
        screen: const PartnerOffersScreen(),
        icon: Icons.handshake,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: AppStrings.txtMyVenue,
        screen: const MyVenuesHomeScreen(),
        icon: Icons.location_on,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: AppStrings.txtMyBenefits,
        screen: Container(),
        icon: Icons.restaurant,
        type: HomeNavigatorModel.typeDialog),
    HomeNavigatorModel(
        name: AppStrings.txtMyAccount,
        screen: const MyProfileScreen(),
        icon: Icons.account_circle_outlined,
        type: HomeNavigatorModel.typeScreen),
    HomeNavigatorModel(
        name: AppStrings.txtSeeAll,
        screen: Container(),
        icon: Icons.more_horiz,
        type: HomeNavigatorModel.typeDialog),
  ];

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

  updateShowAllMenuVisibility(bool value) {
    _showSeeAllMenu = value;
    notifyListeners();
  }

  bool get showSeeAllMenu => _showSeeAllMenu;
}
