import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '/data/repositories/SecureStore.dart';

class AppSecureStore implements SecureStore {
  AppSecureStore({
    FlutterSecureStorage? storage,
    AndroidOptions? aOptions,
    IOSOptions? iOptions,
  }) : _storage = storage ??
            FlutterSecureStorage(
                aOptions: aOptions ?? _defaultAndroidOptions,
                iOptions: iOptions ?? _defaultIosOptions);

  final FlutterSecureStorage _storage;
  static const _defaultAndroidOptions =
      AndroidOptions(encryptedSharedPreferences: true, resetOnError: true);
  static const _defaultIosOptions =
      IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  @override
  Future<bool> containsKey({required String key}) {
    return _storage.containsKey(key: key);
  }

  @override
  Future<void> delete({required String key}) => _storage.delete(key: key);

  @override
  Future<void> deleteAll() => _storage.deleteAll();

  @override
  Future<String?> read({required String key}) => _storage.read(key: key);

  @override
  Future<Map<String, String>> readAll() => _storage.readAll();

  @override
  Future<void> write({required String key, required String value}) =>
      _storage.write(key: key, value: value);
}
