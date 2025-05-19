import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import '../../data/models/OfferModel.dart';
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

  getSpecialOffers({bool? hideLoader}) async {
    try {
      if (hideLoader == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showLoader = true;
          notifyListeners();
        });
      }

      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      UserModel? userData = sharedPreferenceHelper.getUserData();

      if (userData != null) {
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

        NetworkResponse networkResponse = await AppDataService.getInstance()
            .fetchSpecialOffers(
                membershipType: userData.statusTier != null &&
                        userData.statusTier!.isNotEmpty
                    ? userData.statusTier!.toLowerCase()
                    : "valued",
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

  getOfferByID({required String offerID}) async {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoader = true;
        notifyListeners();
      });
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      UserModel? userData = sharedPreferenceHelper.getUserData();

      NetworkResponse networkResponse = await AppDataService.getInstance()
          .fetchOfferByID(
              offerID: offerID, userID: userData!.bluizeUniqueUserId!);
      logEvent("OFFER BY ID RESPONSE ${networkResponse}");
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
