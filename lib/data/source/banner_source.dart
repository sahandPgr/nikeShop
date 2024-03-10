import 'package:dio/dio.dart';
import 'package:nike_shop/data/banner.dart';
import 'package:nike_shop/data/common/http_response_validate.dart';


abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class RemoteBannerDataSource
    with HttpResponseValidator
    implements IBannerDataSource {
  final Dio httpClient;

  RemoteBannerDataSource({required this.httpClient});

  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('categories/apparel/');
    // debugPrint(response.data.toString());
    validatorResponse(response);
    final List<BannerEntity> banners = [];
    for (var element in (response.data['data']['slider_banners'] as List)) {
      banners.add(BannerEntity.fromJson(element));
    }
    return banners;
  }
}
