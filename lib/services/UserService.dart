import 'package:qantum_apps/core/network/NetworkHelper.dart';
import 'package:qantum_apps/core/utils/AppHelper.dart';
import 'package:qantum_apps/data/models/NetworkResponse.dart';

import '../core/network/APIList.dart';
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
}
