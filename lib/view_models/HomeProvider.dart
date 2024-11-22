import 'package:flutter/material.dart';
import 'package:qantum_apps/core/utils/AppStrings.dart';
import 'package:qantum_apps/data/models/HomeNavigatorModel.dart';
import 'package:qantum_apps/views/my_benefits/MyBenefitsScreen.dart';

import '../views/digital_card/MyDigitalCardScreen.dart';
import '../views/partners_offer/PartnerOffersScreen.dart';
import '../views/point_balance/PointsBalanceScreen.dart';
import '../views/profile/MyProfileScreen.dart';
import '../views/promotions/PromotionsScreen.dart';
import '../views/special_offers/SpecialOffersScreen.dart';
import '../views/whats_on/WhatsOnScreen.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedOption = 0;

  int get selectedOption => _selectedOption;

  updateSelectedOption(int value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedOption = value;
      notifyListeners();
    });
  }

  final List<HomeNavigatorModel> _homeNavigationList = [
    HomeNavigatorModel(
        name: AppStrings.txtPromotions,
        screen: PromotionsScreen(),
        icon: Icons.star),
    HomeNavigatorModel(
        name: AppStrings.txtMyBenefits,
        screen: const MyBenefitsScreen(),
        icon: Icons.restaurant),
    HomeNavigatorModel(
        name: AppStrings.txtPointsBalance,
        screen: const PointsBalanceScreen(),
        icon: Icons.attach_money),
    HomeNavigatorModel(
        name: AppStrings.txtSpecialOffers,
        screen: const SpecialOffersScreen(),
        icon: Icons.card_giftcard),
    HomeNavigatorModel(
        name: AppStrings.txtWhatsOn,
        screen: const WhatsOnScreen(),
        icon: Icons.event),
    HomeNavigatorModel(
        name: AppStrings.txtPartnerOffers,
        screen: const PartnerOffersScreen(),
        icon: Icons.handshake),
  ];

  List<HomeNavigatorModel> get homeNavigationList => _homeNavigationList;

  Widget get selectedScreen => (_selectedOption == -1)
      ? const MyProfileScreen()
      : (_selectedOption == -2
          ? const MyDigitalCardScreen()
          : _homeNavigationList[_selectedOption].screen);

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
}
