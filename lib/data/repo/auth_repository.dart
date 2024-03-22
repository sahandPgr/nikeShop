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
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;
  static final ValueNotifier<AuthEntity?> authValueNotifier =
      ValueNotifier(null);

  AuthRepository({required this.dataSource});

  @override
  Future<void> login(String username, String password) async {
    try {
      final AuthEntity authInfo = await dataSource.login(username, password);
      _saveAuthToken(authInfo);
      debugPrint('Acess token is ${authInfo.accessToken}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> register(String username, String password) async {
    try {
      final AuthEntity authInfo = await dataSource.register(username, password);
      _saveAuthToken(authInfo);
      debugPrint('Acess token is ${authInfo.accessToken}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> refreshToken(String refreshToken) async {
    try {
      final AuthEntity authInfo = await dataSource.refreshToken(refreshToken);
      _saveAuthToken(authInfo);
      debugPrint('Acess token is ${authInfo.accessToken}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _saveAuthToken(AuthEntity authInfo) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('access_token', authInfo.accessToken);
    sharedPreferences.setString('refresh_token', authInfo.refreshToken);
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
}
