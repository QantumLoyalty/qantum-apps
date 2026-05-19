import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:provider/provider.dart';
import 'package:qantum_apps/core/extensions/log_extension.dart';
import 'package:qantum_apps/data/models/NetworkResponse.dart';
import 'package:qantum_apps/data/models/UserModel.dart';
import 'package:qantum_apps/services/UnitedFuelsService.dart';
import 'package:qantum_apps/view_models/UserInfoProvider.dart';

class UnitedFuelsProvider extends ChangeNotifier {
  String? cardHash;
  String? barcode;
  String? termsAndConditions;
  String? errorInCardHash;
  bool isLoading = false;
  bool isError = false;
  String errorMessage = "";

  loadBarcode(BuildContext context) async {
    try {
      final userInfoProvider = context.read<UserInfoProvider>();
      final userData = userInfoProvider.getUserInfo;
      final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
      isLoading = true;
      resetDefaultValues();
      notifyListeners();
      //   cardHash = "wkM9yjP8Em9";
      // cardHash = "Jvj8JKZ3kQP";
      cardHash = userData?.unitedFuelCardHash;
      cardHash=null;
      print("cardHash: $cardHash");

      if (cardHash == null || cardHash!.isEmpty) {
        /// CHECKING USER VALIDATION
        ("fetchUnitedCardHash called").logMessage;
        await fetchUnitedCardHash(userData!, currentTimeZone);
      } else {
        /// FETCH BARCODE USING EXISTING CARD HASH
        await fetchBarcode(currentTimeZone);
      }
    } catch (e) {
      isError = true;
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  resetDefaultValues() {
    cardHash = null;
    barcode = null;
    termsAndConditions = null;
    errorInCardHash = null;
    isError = false;
    errorMessage = "";
  }

  fetchUnitedCardHash(UserModel userData, String currentTimeZone) async {
    try {
      NetworkResponse validateUserResponse =
          await UnitedFuelsService.getInstance()
              .validateUser(userData.mobile ?? "");
       /*  NetworkResponse validateUserResponse =
          await UnitedFuelsService.getInstance().validateUser("0455875773");*/
      print("Validate User Response:$validateUserResponse");
         print("Validate User Response:${validateUserResponse.isError}");
      if (!validateUserResponse.isError) {

        Map<String, dynamic> responseData =
            validateUserResponse.response as Map<String, dynamic>;

        print("Validate User: ${responseData}");

        if (responseData.containsKey("success") &&
            responseData["success"] == true &&
            responseData.containsKey("data")) {
          Map<String, dynamic> userData =
              responseData["data"] as Map<String, dynamic>;
          cardHash = userData["card_hash"];
          print("Fetched Card Hash:$cardHash");

          /// USER VALIDATED, NOW FETCHING BARCODE
          await fetchBarcode(currentTimeZone);
        } else {
          /// CHECKING IF USER ISN'T REGISTERED WITH UNITED FUELS, IF NOT THEN REGISTERING THE USER AND FETCHING CARD HASH
          ///
          if (responseData.containsKey("registered") &&
              (responseData["registered"] as bool) == false) {
            /// USER ISN'T REGISTERED WITH UNITED FUELS
            Map<String, String> registrationParams = {
              "first_name": userData.firstName ?? "",
              "last_name": userData.lastName ?? "",
              //  "mobile_number": "0420611631",
              "mobile_number": userData.mobile ?? "",
              "email_address": userData.email ?? "",
              "postcode": userData.postCode ?? ""
            };
            print("Registration Params:$registrationParams");
             await registerUserWithUnitedFuels(
                registrationParams, currentTimeZone);
          } else {
            isError = true;
            if (responseData.containsKey("message")) {
              errorMessage = (responseData["message"]);
              errorMessage =
              "${errorMessage}\nPossible reason: User's number is not an australian number or there is a network issue.";
            } else {
              errorMessage = validateUserResponse.responseMessage;
            }
          }

        }
      } else {
        isError = true;
        Map<String, dynamic> responseData =
        validateUserResponse.response as Map<String, dynamic>;

        if (responseData.containsKey("message")) {
          errorMessage = (responseData["message"]);
          errorMessage =
          "${errorMessage}\nPossible reason: User's number is not an australian number or there is a network issue.";
        } else {
          errorMessage = validateUserResponse.responseMessage;
        }

      }
    } catch (e) {
      isError = true;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  fetchBarcode(String currentTimeZone) async {
    try {
      NetworkResponse fetchBarcodeResponse =
          await UnitedFuelsService.getInstance().fetchBarcode(
              cardHash: cardHash!, currentTimeZone: currentTimeZone);
      print("fetchBarcodeResponse>>>$fetchBarcodeResponse");
      if (!fetchBarcodeResponse.isError) {
        Map<String, dynamic> responseData =
            fetchBarcodeResponse.response as Map<String, dynamic>;
        if (responseData.containsKey("success") &&
            responseData["success"] == true &&
            responseData.containsKey("data")) {
          Map<String, dynamic> barcodeData = responseData["data"];
          barcode = barcodeData["barcode"];
          barcode = barcode!.replaceAll(RegExp(r'\s+'), '');
          termsAndConditions = barcodeData["terms"];
          print("Fetched Barcode:$barcode");
        } else {
          isError = true;
          errorMessage = "An error occurred while fetching the barcode.";
        }
      } else {
        isError = true;
        if (fetchBarcodeResponse.response is Map<String, dynamic>) {
          Map<String, dynamic> responseData =
              fetchBarcodeResponse.response as Map<String, dynamic>;
          if (responseData.containsKey("message")) {
            errorMessage = (responseData["message"]);
          } else {
            errorMessage = "An error occurred while fetching the barcode.";
          }
        } else {
          errorMessage = fetchBarcodeResponse.responseMessage;
        }
      }
    } catch (e) {
      isError = true;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  registerUserWithUnitedFuels(
      Map<String, String> registrationParams, String currentTimeZone) async {
    try {
      NetworkResponse registerUserResponse =
          await UnitedFuelsService.getInstance()
              .registerUser(registrationParams);

      print("Register User Response:$registerUserResponse");
      Map<String, dynamic> responseData =
          registerUserResponse.response as Map<String, dynamic>;

      if (!registerUserResponse.isError) {
        if (responseData.containsKey("success") &&
            responseData["success"] == true &&
            responseData.containsKey("data")) {
          Map<String, dynamic> userData =
              responseData["data"] as Map<String, dynamic>;
          cardHash = userData["card_hash"];
          await fetchBarcode(currentTimeZone);
        }
      } else {
        isError = true;
        if (responseData.containsKey("message")) {
          errorMessage = (responseData["message"]);
          errorMessage = errorMessage + errorMessage;
        } else {
          errorMessage = registerUserResponse.responseMessage;
        }
      }

      notifyListeners();
    } catch (e) {
      isError = true;
      errorMessage = e.toString();
      notifyListeners();
    }
  }
}
