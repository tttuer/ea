import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Token {
  final _storage = FlutterSecureStorage();
  final _accessTokenKey = 'access_token';
  final _refreshTokenKey = 'refresh_token';

  Future<void> saveAccessToken(String accessToken) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  Future<void> deleteAllTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}

final tokenProvider = Provider<Token>((ref) {
  return Token();
});
