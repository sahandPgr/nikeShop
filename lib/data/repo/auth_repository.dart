import 'package:flutter/material.dart';
import 'package:nike_shop/data/auth.dart';
import 'package:nike_shop/data/common/http_client.dart';
import 'package:nike_shop/data/source/auth_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository =
    AuthRepository(dataSource: AuthRemoteSource(httpClient: httpClientSecond));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> register(String username, String password);
  Future<void> refreshToken(String refreshToken);
  Future<void> signOut();
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;
  static final ValueNotifier<AuthEntity?> authValueNotifier =
      ValueNotifier(null);

  AuthRepository({required this.dataSource});

  @override
  Future<void> login(String username, String password) async {
    final AuthEntity authInfo = await dataSource.login(username, password);
    _saveAuthToken(authInfo);
    // debugPrint('Acess token is ${authInfo.accessToken}');
  }

  @override
  Future<void> register(String username, String password) async {
    final AuthEntity authInfo = await dataSource.register(username, password);
    _saveAuthToken(authInfo);
    // debugPrint('Acess token is ${authInfo.accessToken}');
  }

  @override
  Future<void> refreshToken(String refreshToken) async {
    try {
      final AuthEntity authInfo = await dataSource.refreshToken(refreshToken);
      // debugPrint(authInfo.refreshToken);
      _saveAuthToken(authInfo);
    } catch (e) {
      signOut();
    }
    // debugPrint('Acess token is ${authInfo.accessToken}');
  }

  Future<void> _saveAuthToken(AuthEntity authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (authInfo.accessToken.isNotEmpty && authInfo.refreshToken.isNotEmpty) {
      sharedPreferences.setString('access_token', authInfo.accessToken);
      sharedPreferences.setString('refresh_token', authInfo.refreshToken);
      authValueNotifier.value = AuthEntity(
          accessToken: authInfo.accessToken,
          refreshToken: authInfo.refreshToken);
    }
  }

  Future<void> loadAuthToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    final String accessToken =
        sharedPreferences.getString('access_token') ?? '';
    final String refreshToken =
        sharedPreferences.getString('refresh_token') ?? '';

    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authValueNotifier.value =
          AuthEntity(accessToken: accessToken, refreshToken: refreshToken);
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authValueNotifier.value = null;
  }
}
