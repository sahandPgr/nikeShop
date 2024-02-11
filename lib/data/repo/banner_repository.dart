
import 'package:nike_shop/data/banner.dart';
import 'package:nike_shop/data/common/http_client.dart';
import 'package:nike_shop/data/source/banner_source.dart';

final bannerRepositry =
    BannerRepositry(dataSource: RemoteBannerDataSource(httpClient: httpClient));

abstract class IBannerReposity {
  Future<List<BannerEntity>> getAll();
}

class BannerRepositry implements IBannerReposity {
  final IBannerDataSource dataSource;

  BannerRepositry({required this.dataSource});

  @override
  Future<List<BannerEntity>> getAll() => dataSource.getAll();
}
