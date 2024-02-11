import 'package:dio/dio.dart';
import 'package:nike_shop/data/banner.dart';
import 'package:nike_shop/utils/exception.dart';

abstract class IBannerDataSource {
  Future<List<BannerEntity>> getAll();
}

class RemoteBannerDataSource implements IBannerDataSource {
  final Dio httpClient;

  RemoteBannerDataSource({required this.httpClient});

  @override
  Future<List<BannerEntity>> getAll() async {
    final response = await httpClient.get('categories/apparel/');
    // debugPrint(response.data.toString());
    final List<BannerEntity> banners = [];
    if (response.statusCode == 200) {
      for (var element in (response.data['data']['slider_banners'] as List)) {
        banners.add(BannerEntity.fromJson(element));
      }
    } else {
      throw AppException();
    }
    return banners;
  }
}
