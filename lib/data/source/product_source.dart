import 'package:dio/dio.dart';
import 'package:nike_shop/data/common/http_response_validate.dart';
import 'package:nike_shop/data/product.dart';

abstract class IProductDataSource {
  Future<List<ProductItem>> getAll(int sort);
  Future<List<ProductItem>> search(String seachKey);
}

class ProductRemoteDataSource
    with HttpResponseValidator
    implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource({required this.httpClient});

  @override
  Future<List<ProductItem>> getAll(int sort) async {
    final response = await httpClient.get(
        'categories/men-sport-shoes-/search/?sort=$sort&seo_url=%2Fcategory-men-sport-shoes-%2F%3Fsort%3D20&page=1');
    // debugPrint(response.data['data']["products"].toString());
    validatorResponse(response);
    final products = <ProductItem>[];
    for (var element in (response.data['data']["products"] as List)) {
      products.add(ProductItem.fromJson(element));
    }

    return products;
  }

  @override
  Future<List<ProductItem>> search(String seachKey) {
    throw UnimplementedError();
  }
}
