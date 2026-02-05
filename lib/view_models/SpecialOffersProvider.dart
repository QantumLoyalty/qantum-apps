import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:qantum_apps/core/enums/OffersFilterType.dart';
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

  List<OfferModel>? _specialOffersOriginal;
  List<OfferModel>? _specialOffers;

  List<OfferModel>? get specialOffers => _specialOffers;

  OfferModel? _selectedOffer;

  OfferModel? get selectedOffer => _selectedOffer;

  Timer? _fetchSpecialOfferTimer;

  String? _filterResponse;
  bool? _isErrorOnFilterResponse;

  String? get filterResponse => _filterResponse;

  bool? get isErrorOnFilterResponse => _isErrorOnFilterResponse;

  List<String>? _offersFilters;

  List<String>? get offersFilters => _offersFilters;

  String? _selectedFilter;

  String? get selectedFilter => _selectedFilter;

  updateSelectedFilter(String? value) {
    if (value == null) {
      _selectedFilter = "ALL";
    } else {
      _selectedFilter = value;
    }
    applyFilterOnOffers();
    notifyListeners();
  }

  applyFilterOnOffers() {
    if (_specialOffersOriginal != null && _specialOffersOriginal!.isNotEmpty) {
      if (_selectedFilter == null || _selectedFilter == "ALL") {
        _specialOffers = null;
        _specialOffers = _specialOffersOriginal;
      } else {
        _specialOffers = _specialOffersOriginal!
            .where((value) =>
                value.appears != null &&
                value.appears!.toUpperCase() == _selectedFilter!.toUpperCase())
            .toList();
      }
    } else {
      _specialOffers = [];
    }

    notifyListeners();
  }

  getSpecialOffersFilters({bool? showLoader}) async {
    try {
      if (showLoader != null && showLoader) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showLoader = true;
          notifyListeners();
        });
      }

      NetworkResponse networkResponse =
          await AppDataService.getInstance().fetchSpecialOffersFilters();
      logEvent(networkResponse);

      if (networkResponse.response != null &&
          networkResponse.response is Map<String, dynamic>) {
        var apiResponse = networkResponse.response as Map<String, dynamic>;
        if (apiResponse.containsKey('success') &&
            (apiResponse['success'] as bool)) {
          if (apiResponse.containsKey('data')) {
            if (apiResponse['data'] != null) {
              var filterData = apiResponse['data'] as Map<String, dynamic>;
              _isErrorOnFilterResponse = false;

              if (filterData.containsKey('menu_Type') &&
                  filterData['menu_Type'].toString().toLowerCase() ==
                      OffersFilterType.multiple.name) {
                _offersFilters = ['ALL'];

                if (filterData.containsKey('filter_Type')) {
                  filterData['filter_Type'].forEach((item) {
                    _offersFilters!.add(item);
                  });
                }
              }
            }

            getSpecialOffers(showLoader: false);
          } else {
            _isErrorOnFilterResponse = true;
            _filterResponse =
                "Error while fetching the special offers filters!";
          }
        } else {
          _isErrorOnFilterResponse = true;
          _filterResponse = networkResponse.responseMessage;
        }
      } else {
        _isErrorOnFilterResponse = true;
        _filterResponse = "Error while fetching the special offers filters!";
      }
    } catch (e) {
      _isErrorOnFilterResponse = true;
      _filterResponse = e.toString();
    } finally {
      _showLoader = false;
      notifyListeners();
    }
  }

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
            _specialOffersOriginal = [];
            response["data"].forEach((item) {
              _specialOffersOriginal!.add(OfferModel.fromJson(item));
            });

            logEvent(
                "SPECIAL OFFERS LIST SIZE ${_specialOffersOriginal?.length}");
            applyFilterOnOffers();
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
    //await getSpecialOffers(showLoader: true);
    await getSpecialOffersFilters();

    _fetchSpecialOfferTimer = Timer.periodic(
        Duration(seconds: AppHelper.defaultRequestTime), (value) async {
      if (!_isFetching) {
        _isFetching = true;
        //  await getSpecialOffers(showLoader: false);
        await getSpecialOffersFilters();
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
