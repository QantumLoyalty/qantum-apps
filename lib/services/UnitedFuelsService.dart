import 'package:qantum_apps/data/models/NetworkResponse.dart';
import 'package:qantum_apps/data/repositories/UnitedFuelsRepository.dart';

import '../core/mixins/logging_mixin.dart';
import '../core/network/APIList.dart';
import '../core/network/NetworkHelper.dart';
import '../data/local/SharedPreferenceHelper.dart';

class UnitedFuelsService with LoggingMixin implements UnitedFuelsRepository
{
  static UnitedFuelsService? _instance;

  UnitedFuelsService._internal();

  static UnitedFuelsService getInstance() {
    _instance ??= UnitedFuelsService._internal();
    return _instance!;
  }
  @override
  Future<NetworkResponse> fetchBarcode({required String cardHash,required String currentTimeZone}) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
      await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance.getCall(
          url: Uri.parse("${APIList.FETCH_BARCODE}$cardHash?timezone=$currentTimeZone"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()}'
          }
      );
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }

    return networkResponse;
  }

  @override
  Future<NetworkResponse> registerUser(Map<String, dynamic> params) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
      await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance.postCall(
          url: Uri.parse(APIList.REGISTER_USER_WITH_UNITED),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()}'
          },
          body: params


      );
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }

    return networkResponse;
  }

  @override
  Future<NetworkResponse> validateUser(String phoneNo) async {
    NetworkResponse networkResponse;
    try {
      SharedPreferenceHelper sharedPreferenceHelper =
      await SharedPreferenceHelper.getInstance();
      var response = await NetworkHelper.instance.getCall(
          url: Uri.parse("${APIList.VALIDATE_USER}$phoneNo"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${sharedPreferenceHelper.getAuthToken()}'
          }

      );
      networkResponse = response;
    } catch (e) {
      networkResponse = NetworkResponse.error(responseMessage: e.toString());
    }

    return networkResponse;
  }

}