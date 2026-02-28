
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
final secureStorageProvider = Provider<_SecureStorage>((ref) {
  final localStorage = FlutterSecureStorage();
  return _SecureStorage(localStorage: localStorage);
});

class _SecureStorage {
  _SecureStorage({required this.localStorage});
  final FlutterSecureStorage localStorage;
  static final String accessTokenKey = 'access_token';
  static final String refreshTokenKey = 'refresh_token';

  Future<String?> getAccessToken()async {
    return await localStorage.read(key: accessTokenKey);
  }
 Future<String?> getRefreshToken()async {
    return await localStorage.read(key: refreshTokenKey);
  }

  Future<void> setAccessToken(String token)async {
    await localStorage.write(key: accessTokenKey,value: token);
  }

  Future<void> clearAccessToken() async {
    await localStorage.delete(key: accessTokenKey);
  }
  Future<void> setRefreshToken(String token)async {
    await localStorage.write(key: refreshTokenKey,value: token);
  }

  Future<void> clearRefreshToken() async {
    await localStorage.delete(key: refreshTokenKey);
  }
}