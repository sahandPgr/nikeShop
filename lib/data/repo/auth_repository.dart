import 'package:nike_shop/data/common/http_client.dart';
import 'package:nike_shop/data/source/auth_data_source.dart';

final authRepository =
    AuthRepository(dataSource: AuthRemoteSource(httpClient: httpClientSecond));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository({required this.dataSource});

  @override
  Future<void> login(String username, String password) {
    return dataSource.login(username, password);
  }
}
