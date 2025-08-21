import '/core/mixins/logging_mixin.dart';
import '/core/utils/AppHelper.dart';
import '/data/models/UserModel.dart';

import '../core/network/NetworkHelper.dart';
import '../data/models/NetworkResponse.dart';
import '../core/network/APIList.dart';
import '../data/local/SharedPreferenceHelper.dart';
import '../data/repositories/UserRepository.dart';

class UserService with LoggingMixin implements UserRepository {
  static UserService? _instance;

  UserService._internal();

  static UserService getInstance() {
    _instance ??= UserService._internal();
    return _instance!;
  }

  @override
  Future<NetworkResponse> login(String phoneNo) async {
    NetworkResponse networkResponse;
    try {
      var response = await NetworkHelper.instance.getCall(
          url: Uri.parse(
              "${APIList.LOGIN}$phoneNo?appType=${AppHelper.getAppType()}"));
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }

    return networkResponse;
  }

  @override
  Future<NetworkResponse> signup(
      String phoneNo, Map<String, dynamic> signupParams) async {
    NetworkResponse networkResponse;
    try {
      var response = await NetworkHelper.instance.postCall(
          url: Uri.parse(
              "${APIList.REGISTRATION}$phoneNo?appType=${AppHelper.getAppType()}"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: signupParams);
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> verifyOTP(Map<String, dynamic> params) async {
    NetworkResponse networkResponse;
    try {
      var response = await NetworkHelper.instance.postCall(
          url: Uri.parse(
              APIList.VERIFY_OTP + "?appType=${AppHelper.getAppType()}"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: params);
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> uploadDeviceToken(
      String authToken, Map<String, dynamic> params) async {
    NetworkResponse networkResponse;
    try {
      var response = await NetworkHelper.instance.putCall(
          url: Uri.parse(APIList.UPLOAD_DEVICE_TOKEN),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $authToken'
          },
          body: params);
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> fetchUserProfile() async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance
          .postCall(url: Uri.parse(APIList.GET_PROFILE), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()}'
      }, body: {});
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> getPoints() async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance
          .getCall(url: Uri.parse(APIList.GET_POINTS), headers: {
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
  Future<NetworkResponse> cancelAccount() async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance
          .putCall(url: Uri.parse(APIList.CANCEL_ACCOUNT), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
      }, body: {});
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> sendOTPAccount(Map<String, dynamic> params) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance.postCall(
          url: Uri.parse(APIList.SEND_OTP_PROFILE),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
          },
          body: params);
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> resendOTPAccount(Map<String, dynamic> params) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance.postCall(
          url: Uri.parse(APIList.RESEND_OTP_PROFILE),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
          },
          body: params);
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> verifyOTPAccount(Map<String, dynamic> params) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance.postCall(
          url: Uri.parse(APIList.VERIFY_OTP_PROFILE),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
          },
          body: params);
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> updateUserProfile(Map<String, dynamic> params) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance.putCall(
          url: Uri.parse(APIList.UPDATE_USER_INFO),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
          },
          body: params);
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> sendOTPEmail({required String phoneNo}) async {
    NetworkResponse networkResponse;
    try {
      var response = await NetworkHelper.instance.postCall(
          url: Uri.parse(
              APIList.SEND_OTP_EMAIL + "?appType=${AppHelper.getAppType()}"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: {
            "Mobile": phoneNo
          });
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> resendOTPEmail({required String phoneNo}) async {
    NetworkResponse networkResponse;
    try {
      var response = await NetworkHelper.instance.postCall(
          url: Uri.parse(APIList.RESEND_OTP_EMAIL +
              phoneNo +
              "?appType=${AppHelper.getAppType()}"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: {});
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> verifyOTPEmail(
      String phoneNo, Map<String, dynamic> params) async {
    NetworkResponse networkResponse;
    try {
      var response = await NetworkHelper.instance.postCall(
          url: Uri.parse(APIList.VERIFY_OTP_EMAIL +
              phoneNo +
              "?appType=${AppHelper.getAppType()}"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: params);
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> sendOTPNewPhone({required String phoneNo}) async {
    NetworkResponse networkResponse;
    try {
      var response = await NetworkHelper.instance.postCall(
          url: Uri.parse(APIList.SEND_OTP_NEW_NUMBER +
              "?appType=${AppHelper.getAppType()}"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: {
            "Mobile": phoneNo
          });
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> resendOTPNewPhone({required String phoneNo}) async {
    NetworkResponse networkResponse;
    try {
      var response = await NetworkHelper.instance.postCall(
          url: Uri.parse(APIList.RESEND_OTP_NEW_NUMBER + phoneNo),
          headers: {
            'Content-Type': 'application/json',
          },
          body: {});
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> verifyOTPNewPhone(Map<String, dynamic> params) async {
    NetworkResponse networkResponse;
    try {
      var response = await NetworkHelper.instance.putCall(
          url: Uri.parse(APIList.VERIFY_OTP_NEW_NUMBER +
              "?appType=${AppHelper.getAppType()}"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: params);
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> updateDeviceDetail(
      Map<String, dynamic> params) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance.putCall(
          url: Uri.parse(APIList.UPDATE_DEVICE_DETAILS),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
          },
          body: params);
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> checkForAppUpdate(Map<String, dynamic> params) async {
    NetworkResponse networkResponse;
    try {
      logEvent("URL:${APIList.CHECK_APP_UPDATE} --> PARAMS: $params");
      var response = await NetworkHelper.instance.putCall(
          url: Uri.parse(APIList.CHECK_APP_UPDATE),
          headers: {
            'Content-Type': 'application/json',
          },
          body: params);
      networkResponse = response;
      logEvent("APP UPDATE NETWORK RESPONSE:$response");
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }
    return networkResponse;
  }

  @override
  Future<NetworkResponse> getUsersBenefits() async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
          await SharedPreferenceHelper.getInstance();

      UserModel? user = await sharedPreferenceHelper.getUserData();

      final String userStatusTier = await AppHelper.getUserTierType(user!);

      var response = await NetworkHelper.instance.getCall(
          url: Uri.parse(APIList.GET_USERS_BENEFITS + "type=$userStatusTier"),
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
}
