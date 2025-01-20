import '../core/network/NetworkHelper.dart';
import '../data/models/NetworkResponse.dart';
import '../core/network/APIList.dart';
import '../data/local/SharedPreferenceHelper.dart';
import '../data/repositories/UserRepository.dart';

class UserService implements UserRepository {
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
      var response = await NetworkHelper.instance
          .getCall(url: Uri.parse(APIList.LOGIN + phoneNo));
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
          url: Uri.parse(APIList.REGISTRATION + phoneNo),
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
          url: Uri.parse(APIList.VERIFY_OTP),
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
        'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()!}'
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
}
