import 'package:qantum_apps/data/models/NetworkResponse.dart';

abstract class UserRepository {
  Future<NetworkResponse> login(String phoneNo);
}
