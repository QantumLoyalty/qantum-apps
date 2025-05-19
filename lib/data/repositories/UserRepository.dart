import '../models/NetworkResponse.dart';

abstract class UserRepository {
  Future<NetworkResponse> login(String phoneNo);

  Future<NetworkResponse> signup(
      String phoneNo, Map<String, dynamic> signupParams);

  Future<NetworkResponse> verifyOTP(Map<String, dynamic> params);

  Future<NetworkResponse> uploadDeviceToken(
      String authToken, Map<String, dynamic> params);

  Future<NetworkResponse> getPoints();

  Future<NetworkResponse> getUsersBenefits();

  Future<NetworkResponse> cancelAccount();

  Future<NetworkResponse> fetchUserProfile();

  Future<NetworkResponse> updateUserProfile(Map<String, dynamic> params);

  Future<NetworkResponse> sendOTPAccount(Map<String, dynamic> params);

  Future<NetworkResponse> resendOTPAccount(Map<String, dynamic> params);

  Future<NetworkResponse> verifyOTPAccount(Map<String, dynamic> params);

  Future<NetworkResponse> sendOTPNewPhone({required String phoneNo});

  Future<NetworkResponse> sendOTPEmail({required String phoneNo});

  Future<NetworkResponse> resendOTPEmail({required String phoneNo});

  Future<NetworkResponse> resendOTPNewPhone({required String phoneNo});

  Future<NetworkResponse> verifyOTPEmail(
      String phoneNo, Map<String, dynamic> params);

  Future<NetworkResponse> verifyOTPNewPhone(Map<String, dynamic> params);

  Future<NetworkResponse> updateDeviceDetail(Map<String, dynamic> params);
  Future<NetworkResponse> checkForAppUpdate(Map<String, dynamic> params);
}
