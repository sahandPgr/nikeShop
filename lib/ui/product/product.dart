import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop/data/product.dart';
import 'package:nike_shop/ui/product/detail.dart';
import 'package:nike_shop/ui/widgets/image_service.dart';
import 'package:nike_shop/utils/utils.dart';

class ProductBlock extends StatelessWidget {
  final ProductItem product;

  const ProductBlock({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) => ProductDetail(product: product,))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
        child: SizedBox(
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ImageLoadingService(imageurl: product.imageUrl.toString()),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: const Icon(
                        CupertinoIcons.heart,
                        size: 24,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 170,
                child: Text(
                  product.itemTitle.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 4,),
              Text(
               product.price == product.priceOffer ? '' : product.priceOffer.getPriceLabel,
                style: themeData.textTheme.bodySmall!
                    .apply(decoration: TextDecoration.lineThrough),
              ),
              Text(product.price.getPriceLabel),
            ],
          ),
        ),
      ),
    );
  }
}
