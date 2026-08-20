import '../models/NetworkResponse.dart';

abstract class UserRepository {
  Future<NetworkResponse> login(String phoneNo);
  Future<NetworkResponse> checkEmail({required String email});

  Future<NetworkResponse> signup(
      String phoneNo, Map<String, dynamic> signupParams);

  Future<NetworkResponse> verifyOTP(Map<String, dynamic> params);

  Future<NetworkResponse> uploadDeviceToken(
      String authToken, Map<String, dynamic> params);

  Future<NetworkResponse> getPoints();

  Future<NetworkResponse> getUsersBenefits();

  Future<NetworkResponse> cancelAccount();

  Future<NetworkResponse> fetchUserProfile({required String fetchFromBluize});

  Future<NetworkResponse> updateUserProfile(Map<String, dynamic> params);

  Future<NetworkResponse> sendOTPAccount(Map<String, dynamic> params);

  Future<NetworkResponse> resendOTPAccount(Map<String, dynamic> params);

  Future<NetworkResponse> verifyOTPAccount(Map<String, dynamic> params);

  Future<NetworkResponse> sendOTPNewPhone({required String phoneNo});

  Future<NetworkResponse> sendOTPEmail({required String phoneNo});

  Future<NetworkResponse> resendOTPEmail({required String phoneNo});

  Future<NetworkResponse> resendOTPNewPhone({required String phoneNo});
  Future<NetworkResponse> fetchStatusTierValue({required String statusTier});

  Future<NetworkResponse> verifyOTPEmail(
      String phoneNo, Map<String, dynamic> params);

  Future<NetworkResponse> verifyOTPNewPhone(Map<String, dynamic> params);

  Future<NetworkResponse> updateDeviceDetail(Map<String, dynamic> params);

  Future<NetworkResponse> checkForAppUpdate(Map<String, dynamic> params);

  Future<NetworkResponse> uploadSelfie(String filePath);
  Future<NetworkResponse> resendOTP({required String phoneNumber});
  Future<NetworkResponse> sendOTPOnEmail({required String email});
  Future<NetworkResponse> verifyOTPOfEmail({required Map<String,dynamic> params});

  Future<NetworkResponse> logout();
}
