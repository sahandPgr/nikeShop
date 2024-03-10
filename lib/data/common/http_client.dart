import 'package:dio/dio.dart';

final httpClient = Dio(BaseOptions(baseUrl: 'https://api.digikala.com/v1/'));
final httpClientSecond = Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1'));
