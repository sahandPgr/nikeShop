import 'package:flutter/material.dart';
import 'package:nike_shop/data/auth.dart';
import 'package:nike_shop/data/common/http_client.dart';
import 'package:nike_shop/data/source/auth_data_source.dart';

final authRepository =
    AuthRepository(dataSource: AuthRemoteSource(httpClient: httpClientSecond));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> register(String username, String password);
  Future<void> refreshToken(String refreshToken);
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository({required this.dataSource});

  @override
  Future<void> login(String username, String password) async {
    try {
      final AuthEntity authInfo = await dataSource.login(username, password);
      debugPrint('Acess token is ${authInfo.accessToken}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> register(String username, String password) async {
    try {
      final AuthEntity authInfo = await dataSource.register(username, password);
      debugPrint('Acess token is ${authInfo.accessToken}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> refreshToken(String refreshToken) async {
    try {
      final AuthEntity authInfo = await dataSource.refreshToken(refreshToken);
      debugPrint('Acess token is ${authInfo.accessToken}');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
