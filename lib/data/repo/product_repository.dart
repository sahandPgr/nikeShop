import 'package:nike_shop/data/common/http_client.dart';
import 'package:nike_shop/data/product.dart';
import 'package:nike_shop/data/source/product_source.dart';

final productRepository = ProductRepository(
    dataSource: ProductRemoteDataSource(httpClient: httpClient));

abstract class IProductRepository {
  Future<List<ProductItem>> getAll(int sort);
  Future<List<ProductItem>> search(String seachKey);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository({required this.dataSource});

  @override
  Future<List<ProductItem>> getAll(int sort) => dataSource.getAll(sort);

  @override
  Future<List<ProductItem>> search(String seachKey) =>
      dataSource.search(seachKey);
}
