class Product {
  static const int latest = 1;
  static const int lowest = 20;
  static const int highest = 21;
  static const int popular = 7;
}

class ProductItem {
  int id;
  String itemTitle;
  String imageUrl;
  int price;
  int priceOffer;

  ProductItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        itemTitle = json['title_fa'],
        imageUrl = json['images']['main']['url'][0],
        price = json['default_variant']['price']['rrp_price'],
        priceOffer =  json['default_variant']['price']['selling_price'];
}
