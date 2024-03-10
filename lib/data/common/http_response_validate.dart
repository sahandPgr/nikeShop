import 'package:dio/dio.dart';
import 'package:nike_shop/utils/exception.dart';

mixin class HttpResponseValidator {
  void validatorResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
