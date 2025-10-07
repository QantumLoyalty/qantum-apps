import 'dart:convert';

import '../core/mixins/logging_mixin.dart';
import '../core/network/APIList.dart';
import '../core/network/NetworkHelper.dart';
import '../data/local/SharedPreferenceHelper.dart';
import '../data/models/NetworkResponse.dart';
import '../data/repositories/AppDataRepository.dart';
import 'package:http/http.dart' as http;

class AppDataService extends AppDataRepository with LoggingMixin {
  static AppDataService? _instance;

  AppDataService._internal();

  static AppDataService getInstance() {
    _instance ??= AppDataService._internal();
    return _instance!;
  }

  @override
  Future<NetworkResponse> fetchPartnerOffers() {
    // TODO: implement fetchPartnerOffers
    throw UnimplementedError();
  }

  @override
  Future<NetworkResponse> fetchPromotions(String membershipType) async {
    NetworkResponse networkResponse;
    try {
      // var URL = APIList.FETCH_PROMOTIONS + membershipType;
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance.getCall(
          url: Uri.parse(APIList.FETCH_PROMOTIONS + membershipType),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
          });
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }

    return networkResponse;
  }

  @override
  Future<NetworkResponse> fetchSpecialOffers(
      {required String membershipType,
      required String birthdayMonth,
      required String userId,
      required String joinDate,
      required String timezone}) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var URL = APIList.FETCH_VOUCHERS +
          "$membershipType&birthMonth=$birthdayMonth&userId=$userId&joinDate=$joinDate&timezone=$timezone";
      logEvent(URL);
      var response =
          await NetworkHelper.instance.getCall(url: Uri.parse(URL), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
      });
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }

    return networkResponse;
  }

  @override
  Future<NetworkResponse> fetchOfferByID(
      {required String offerID, required String userID}) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var URL = APIList.FETCH_VOUCHER_BY_ID + "$offerID?user_id=$userID";
      logEvent(URL);
      var response =
          await NetworkHelper.instance.getCall(url: Uri.parse(URL), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
      });
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }

    return networkResponse;
  }

  @override
  Future<NetworkResponse> fetchSeeAllButtons() async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var URL = APIList.FETCH_HOME_BUTTONS;
      logEvent(URL);
      var response =
          await NetworkHelper.instance.getCall(url: Uri.parse(URL), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()}'
      });
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }

    return networkResponse;
  }

  @override
  Future<NetworkResponse> updateCouponCode({required String couponCode}) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var URL = APIList.UPDATE_COUPON_CODE;
      logEvent(URL);
      var response =
          await NetworkHelper.instance.putCall(url: Uri.parse(URL), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
      }, body: {
        'coupon_codes': couponCode
      });
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> fetchDLInformation(
      {required String frontImagePath, required String backImagePath}) async {
    NetworkResponse networkResponse;
    try {
      var URL =
          "https://licensedataextractorapp.blackfield-3f4ad4c0.australiaeast.azurecontainerapps.io/licensedataextract";
      logEvent(URL);

      final request = http.MultipartRequest('POST', Uri.parse(URL));
      request.headers['Content-Type'] = 'multipart/form-data';
      request.files
          .add(await http.MultipartFile.fromPath('frontimage', frontImagePath));
      request.files
          .add(await http.MultipartFile.fromPath('backimage', backImagePath));
      final streamedResponse = await request.send();
      if (streamedResponse.statusCode == 200) {
        final respStr = await streamedResponse.stream.bytesToString();

        networkResponse = NetworkResponse.success(
            response: jsonDecode(respStr), responseMessage: "Success");
      } else {
        print(
            "RESPONSE: ${streamedResponse.statusCode}: MESSAGE: ${streamedResponse.reasonPhrase}");
        networkResponse = NetworkResponse.error(
            responseMessage: "Error: ${streamedResponse.statusCode}");
      }
      // networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }
}
