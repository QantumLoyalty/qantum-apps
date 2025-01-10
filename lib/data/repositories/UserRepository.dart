import 'package:qantum_apps/data/models/NetworkResponse.dart';

abstract class UserRepository {
  Future<NetworkResponse> login(String phoneNo);

  Future<NetworkResponse> signup(
      String phoneNo, Map<String, dynamic> signupParams);

  Future<NetworkResponse> verifyOTP(Map<String, dynamic> params);

  Future<NetworkResponse> uploadDeviceToken(
      String authToken, Map<String, dynamic> params);

  Future<NetworkResponse> getPoints();

  Future<NetworkResponse> cancelAccount();

  Future<NetworkResponse> fetchUserProfile();
}
