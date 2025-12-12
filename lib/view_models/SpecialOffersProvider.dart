import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import '../../data/models/OfferModel.dart';
import '../core/utils/AppHelper.dart';
import '../data/models/NetworkResponse.dart';
import '../core/mixins/logging_mixin.dart';
import '../data/local/SharedPreferenceHelper.dart';
import '../data/models/UserModel.dart';
import '../services/AppDataService.dart';

class SpecialOffersProvider extends ChangeNotifier with LoggingMixin {
  bool? _showLoader;

  bool? get showLoader => _showLoader;

  bool? _isError;

  bool? get isError => _isError;

  String? _networkMessage;

  String? get networkMessage => _networkMessage;

  List<OfferModel>? _specialOffers;

  List<OfferModel>? get specialOffers => _specialOffers;

  OfferModel? _selectedOffer;

  OfferModel? get selectedOffer => _selectedOffer;

  Timer? _fetchSpecialOfferTimer;

  getSpecialOffers({bool? showLoader}) async {
    try {
      if (showLoader != null && showLoader) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showLoader = true;
          notifyListeners();
        });
      }

      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      UserModel? userData = await sharedPreferenceHelper.getUserData();

      if (userData != null && !userData.isUserStatusCancelled()) {
        DateTime? dob;
        try {
          dob = DateFormat("yyyy-MM-ddThh:mm:ss.000Z")
              .parse(userData.dateOfBirth ?? "");
        } catch (e) {
          logEvent("Exception in parsing birthdate $e");
        }
        DateTime? joinDate;
        try {
          joinDate = DateFormat("yyyy-MM-ddThh:mm:ss.000Z")
              .parse(userData.dateJoined ?? "");
        } catch (e) {
          logEvent("Exception in parsing birthdate $e");
        }

        final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

        final String userStatusTier = await AppHelper.getUserTierType(userData);

        NetworkResponse networkResponse = await AppDataService.getInstance()
            .fetchSpecialOffers(
                membershipType: userStatusTier,
                birthdayMonth: dob != null ? "${dob.month}" : "1",
                userId: userData.bluizeUniqueUserId!,
                joinDate: DateFormat("yyyy-MM-dd").format(joinDate!),
                timezone: currentTimeZone);
        logEvent("Special Offers Response: ${networkResponse.response}");
        if (!networkResponse.isError) {
          _isError = networkResponse.isError;
          Map<String, dynamic> response =
              networkResponse.response as Map<String, dynamic>;
          if (response.keys.contains("success") &&
              (response["success"] as bool) &&
              (response.keys.contains("data"))) {
            _specialOffers = [];
            response["data"].forEach((item) {
              _specialOffers!.add(OfferModel.fromJson(item));
            });

            logEvent("SPECIAL OFFERS LIST SIZE ${_specialOffers?.length}");
          }
        }
      }
    } catch (e) {
      _isError = true;
      _networkMessage = e.toString();
      logEvent(_networkMessage);
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  fetchSpecialOffersTimer() async {
    await getSpecialOffers(showLoader: true);
    _fetchSpecialOfferTimer = Timer.periodic(
        Duration(seconds: AppHelper.defaultRequestTime), (value) async {
      if (!_isFetching) {
        _isFetching = true;
        await getSpecialOffers(showLoader: false);
        _isFetching = false;
      }
    });
  }

  stopSpecialOffersTimer() {
    logEvent("Stopping the timer");
    _fetchSpecialOfferTimer?.cancel();
  }

  getOfferByID({required String offerID}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      UserModel? userData = await sharedPreferenceHelper.getUserData();

      NetworkResponse networkResponse = await AppDataService.getInstance()
          .fetchOfferByID(
              offerID: offerID, userID: userData!.bluizeUniqueUserId!);
      logEvent("OFFER BY ID RESPONSE $networkResponse");
      if (!networkResponse.isError) {
        Map<String, dynamic> response =
            networkResponse.response as Map<String, dynamic>;
        if (response.keys.contains("success") &&
            (response["success"] as bool) &&
            (response.keys.contains("data"))) {
          _selectedOffer = OfferModel.fromJson(response["data"]);
        }
      }
    } catch (e) {
      _isError = true;
      _networkMessage = e.toString();
      logEvent(_networkMessage);
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = false;
        notifyListeners();
      });
    }
  }

  resetSelectedOffer() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedOffer = null;
      notifyListeners();
    });
  }
}
