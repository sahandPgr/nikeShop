import 'package:dio/dio.dart';
import 'package:nike_shop/data/auth.dart';
import 'package:nike_shop/data/common/constant.dart';
import 'package:nike_shop/data/common/http_response_validate.dart';

abstract class IAuthDataSource {
  Future<AuthEntity> login(String username, String password);
  Future<AuthEntity> register(String username, String password);
  Future<AuthEntity> refreshToken(String refreshToken);
}

class AuthRemoteSource with HttpResponseValidator implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteSource({required this.httpClient});

  @override
  Future<AuthEntity> login(String username, String password) async {
    final response = await httpClient.post('/auth/token', data: {
      'grant_type': 'password',
      'client_id': '2',
      'client_secret': Constant.client_secret,
      'username': username,
      'password': password
    });
    validatorResponse(response);

    return AuthEntity(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token']);
  }

  @override
  Future<AuthEntity> refreshToken(String refreshToken) async {
    final response = await httpClient.post('/auth/token', data: {
      'grant_type': 'refresh_token',
      'refresh_token': refreshToken,
      'client_id': "2",
      'client_secret': Constant.client_secret
    });

    validatorResponse(response);

    return AuthEntity(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token']);
  }

  @override
  Future<AuthEntity> register(String username, String password) async {
    final response = await httpClient.post('/user/register',
        data: {"email": username, "password": password});
    validatorResponse(response);
    return login(username, password);
  }
}
