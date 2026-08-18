import '../models/NetworkResponse.dart';

abstract class UnitedFuelsRepository
{
  Future<NetworkResponse> validateUser(String phoneNo);
  Future<NetworkResponse> fetchBarcode({required String cardHash,required String currentTimeZone});
  Future<NetworkResponse> registerUser(Map<String, dynamic> params);



}