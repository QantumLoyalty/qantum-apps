import 'dart:convert';

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:http_parser/http_parser.dart';
import '../core/utils/AppHelper.dart';
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
      final request = http.MultipartRequest(
          'POST', Uri.parse(APIList.SCAN_DRIVING_LICENSE_IMAGES));
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

  @override
  Future<NetworkResponse> uploadDLImages(
      {required String frontImagePath, required String backImagePath}) async {
    NetworkResponse networkResponse;
    try {
      logEvent(
          "URL: ${APIList.UPLOAD_DRIVING_LICENSE_IMAGES}, Front: $frontImagePath, Back: $backImagePath");
      final request = http.MultipartRequest(
          'POST', Uri.parse(APIList.UPLOAD_DRIVING_LICENSE_IMAGES));
      request.headers['Content-Type'] = 'multipart/form-data';
      request.files.add(await http.MultipartFile.fromPath(
          'front', frontImagePath,
          contentType: MediaType('image', 'png')));
      request.files.add(await http.MultipartFile.fromPath('back', backImagePath,
          contentType: MediaType('image', 'png')));
      logEvent(
          "HEADERS: ${request.headers} --> ${request.files.map((f) => f.filename).toList()}");

      final streamedResponse = await request.send();
      if (streamedResponse.statusCode == 200) {
        final respStr = await streamedResponse.stream.bytesToString();

        networkResponse = NetworkResponse.success(
            response: jsonDecode(respStr), responseMessage: "Success");
      } else {
        networkResponse = NetworkResponse.error(
            responseMessage: "Error: ${streamedResponse.statusCode}");
      }
      // networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> fetchMembershipPlans() async {
    NetworkResponse networkResponse;
    try {
      final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
      final appType = AppHelper.getAppType();

      var url = Uri.parse(APIList.FETCH_MEMBERSHIP_PLAN +
          "timezone=$currentTimeZone&appType=$appType");
      //var url = Uri.parse(APIList.FETCH_MEMBERSHIP_PLAN + "timezone=$currentTimeZone&appType=$appType");

      var response = await NetworkHelper.instance.getCall(url: url, headers: {
        'Content-Type': 'application/json',
      });
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> createPaymentIntent(
      {required Map<String, dynamic> paymentParams}) async {
    NetworkResponse networkResponse;
    try {
      var url = Uri.parse(APIList.CREATE_PAYMENT_INTENT);
      networkResponse = await NetworkHelper.instance.postCall(
          url: url,
          headers: {'Content-Type': 'application/json'},
          body: paymentParams);
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> updatePaymentType(
      {required Map<String, dynamic> paymentParams}) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var url = Uri.parse(APIList.UPDATE_PAYMENT_TYPE);
      networkResponse = await NetworkHelper.instance.putCall(
          url: url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
          },
          body: paymentParams);
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> verifyPayment(
      {required Map<String, dynamic> paymentParams}) async {
    NetworkResponse networkResponse;
    try {
      var url = Uri.parse(APIList.VERIFY_PAYMENT);
      networkResponse = await NetworkHelper.instance.postCall(
          url: url,
          headers: {'Content-Type': 'application/json'},
          body: paymentParams);
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> fetchSpecialOffersFilters() async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var url = Uri.parse(APIList.FETCH_SPECIAL_OFFERS_FILTERS);
      networkResponse = await NetworkHelper.instance.getCall(
        url: url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
        },
      );
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }
}
