import 'package:flutter/material.dart';
import 'package:qantum_apps/l10n/app_localizations.dart';
import '../data/local/SharedPreferenceHelper.dart';
import '/core/utils/AppHelper.dart';
import '/core/mixins/logging_mixin.dart';
import '/data/models/NetworkResponse.dart';
import '/services/AppDataService.dart';
import '/data/models/MembershipModel.dart';

class MembershipManagerProvider extends ChangeNotifier with LoggingMixin {
  List<MembershipModel> _membershipList = [];

  List<MembershipModel> get membershipList => _membershipList;

  MembershipModel? _selectedMembership;

  MembershipModel? get selectedMembership => _selectedMembership;

  bool? _showLoader;

  bool? get showLoader => _showLoader;

  bool? _errorInResponse;

  bool? get errorInResponse => _errorInResponse;

  String? _networkResponseMessage;

  String? get networkResponseMessage => _networkResponseMessage;

  List<MenuEntry>? _menuEntries;

  List<MenuEntry>? get menuEntries => _menuEntries;

  String? _paymentIntentClientSecret;

  String? get paymentIntentClientSecret => _paymentIntentClientSecret;

  String? _paymentIntentId;

  String? get paymentIntentId => _paymentIntentId;

  bool? _isPaymentVerified;

  bool? get isPaymentVerified => _isPaymentVerified;

  String? _loaderMessage;

  String? get loaderMessage => _loaderMessage;

  bool? _isPaymentMethodUpdated;

  bool? get isPaymentMethodUpdated => _isPaymentMethodUpdated;

  updateDropdownValue(MembershipModel value) async {
    _selectedMembership = value;

    /// STORING SELECTED MEMBERSHIP IN SHARED PREFERENCES
    SharedPreferenceHelper sharedPreferenceHelper =
        await SharedPreferenceHelper.getInstance();

    await sharedPreferenceHelper.saveSelectedMembership(value);

    notifyListeners();
  }

  fetchMembership({required AppLocalizations loc}) async {
    try {
      _showLoader = true;
      _loaderMessage = loc.fetchingMembershipPlan;
      notifyListeners();

      NetworkResponse networkResponse =
          await AppDataService.getInstance().fetchMembershipPlans();

      logEvent("Membership Response: ${networkResponse.responseMessage}");

      if (!networkResponse.isError) {
        _errorInResponse = networkResponse.isError;
        if (!_errorInResponse!) {
          Map<String, dynamic> response =
              networkResponse.response as Map<String, dynamic>;
          if (response.keys.contains("data")) {
            _membershipList = [];

            response["data"].forEach((item) {
              _membershipList.add(MembershipModel.fromJson(item));
            });

            logEvent("MEMBERSHIP LIST SIZE ${_membershipList.length}");
            if (_membershipList.isNotEmpty) {
              updateDropdownValue(_membershipList[0]);
              createMembershipMenuEntries();
            }
          }
        }
      }
    } catch (e) {
      _networkResponseMessage = e.toString();
      _errorInResponse = true;
    } finally {
      _showLoader = false;
      notifyListeners();
    }
  }

  createMembershipMenuEntries() {
    _menuEntries = _membershipList
        .map((membership) => DropdownMenuEntry<MembershipModel>(
              value: membership,
              label:
                  "${membership.membershipName} - \$${membership.calculatedPrice != null ? membership.calculatedPrice!.toStringAsFixed(2) : "0.00"}",
              labelWidget: Container(
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Text(
                  "${membership.membershipName} - \$${membership.calculatedPrice != null ? membership.calculatedPrice!.toStringAsFixed(2) : "0.00"}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              style: const ButtonStyle(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.only(right: 20, top: 15),
                ),
                foregroundColor: WidgetStatePropertyAll(Colors.white),
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              ),
            ))
        .toList();

    notifyListeners();
  }

  resetNetworkResponse() {
    _networkResponseMessage = null;
    _errorInResponse = false;
    notifyListeners();
  }

  createPaymentIntent(
      {required String userId, required AppLocalizations loc}) async {
    try {
      _showLoader = true;
      _paymentIntentClientSecret = null;
      _loaderMessage = loc.msgCommonLoader;
      notifyListeners();

      Map<String, dynamic> paymentParams = {
        "userId": userId,
        "packageId": _selectedMembership!.id!,
        "packageName": _selectedMembership!.membershipName!,
        "amount": (_selectedMembership!.calculatedPrice! * 100).toInt(),
        "currency": "aud",
        "appType": AppHelper.getAppType(),
        "paymentType": "card"
      };
      NetworkResponse networkResponse = await AppDataService.getInstance()
          .createPaymentIntent(paymentParams: paymentParams);

      logEvent(
          "Payment Intent Params $paymentParams Response: ${networkResponse.responseMessage} ==> ${networkResponse.response}");
      _errorInResponse = networkResponse.isError;
      if (!_errorInResponse!) {
        _paymentIntentClientSecret =
            (networkResponse.response as Map<String, dynamic>)["clientSecret"];
        _paymentIntentId = (networkResponse.response
            as Map<String, dynamic>)["paymentIntentId"];
      }
    } catch (e) {
      _errorInResponse = true;
      _networkResponseMessage = e.toString();
    } finally {
      _showLoader = false;
      notifyListeners();
    }
  }

  checkSelectedMembershipInLocal() async {
    if (_selectedMembership == null) {
      /// STORING SELECTED MEMBERSHIP IN SHARED PREFERENCES
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      final hasMembershipData =
          sharedPreferenceHelper.getSelectedMembership() != null;

      if (hasMembershipData) {
        _selectedMembership = sharedPreferenceHelper.getSelectedMembership();
      }

      notifyListeners();
    }
  }

  updateMembershipPaymentMethod({required AppLocalizations loc}) async {
    try {
      _showLoader = true;
      _loaderMessage = loc.msgCommonLoader;
      notifyListeners();

      Map<String, dynamic> paymentParams = {
        "packageName": _selectedMembership!.membershipName!,
        "paymentType": "reception",
        "packageId": _selectedMembership!.id!,
      };
      NetworkResponse networkResponse = await AppDataService.getInstance()
          .updatePaymentType(paymentParams: paymentParams);

      logEvent(
          "Payment Intent Response: ${networkResponse.responseMessage} ==> ${networkResponse.response}");
      _isPaymentMethodUpdated = !networkResponse.isError;
    } catch (e) {
      _errorInResponse = true;
      _networkResponseMessage = e.toString();
    } finally {
      _showLoader = false;
      notifyListeners();
    }
  }

  resetUpdateMembershipPaymentResponse() {
    _isPaymentMethodUpdated = null;
    notifyListeners();
  }

  verifyPayment({required AppLocalizations loc, required String userId}) async {
    try {
      _showLoader = true;
      _loaderMessage = loc.verifyingPayment;
      notifyListeners();

      Map<String, dynamic> paymentParams = {
        "userId": userId,
        "packageId": _selectedMembership!.id!,
        "appType": AppHelper.getAppType(),
        "paymentIntentId": _paymentIntentId,
        "paymentType": "card",
        "packageName": _selectedMembership!.membershipName!
      };
      NetworkResponse networkResponse = await AppDataService.getInstance()
          .verifyPayment(paymentParams: paymentParams);

      logEvent(
          "Verify Payment Params: $paymentParams Response: ${networkResponse.responseMessage} ===> isError: ${networkResponse.isError} ==> ${networkResponse.response}");
      _isPaymentVerified = !networkResponse.isError;
    } catch (e) {
      _isPaymentVerified = false;
      _networkResponseMessage = e.toString();
    } finally {
      _showLoader = false;
      notifyListeners();
    }
  }

  resetVerifyPaymentResponse() {
    _isPaymentVerified = null;
    notifyListeners();
  }
}

typedef MenuEntry = DropdownMenuEntry<MembershipModel>;
