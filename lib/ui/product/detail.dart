import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop/data/product.dart';
import 'package:nike_shop/ui/product/comment/comment_list.dart';
import 'package:nike_shop/ui/widgets/image_service.dart';
import 'package:nike_shop/utils/utils.dart';

class ProductDetail extends StatelessWidget {
  final ProductItem product;

  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width - 100,
          child: FloatingActionButton.extended(
              onPressed: () {}, label: const Text('افزودن به سبد خرید'))),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                collapsedHeight: MediaQuery.of(context).size.width * 0.4,
                expandedHeight: MediaQuery.of(context).size.width * 0.7,
                flexibleSpace:
                    ImageLoadingService(imageurl: product.imageUrl.toString()),
                foregroundColor: Colors.black54,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.heart,
                        color: Colors.black87,
                        size: 24,
                      ))
                ],
              ),
              SliverToBoxAdapter(
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.grey.shade400),
                    width: MediaQuery.of(context).size.width - 30,
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.itemTitle.toString()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product.price == product.priceOffer
                                  ? ''
                                  : product.priceOffer.getPriceLabel,
                              style: themeData.textTheme.bodySmall!.apply(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(product.price.getPriceLabel),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
                    child: Text(
                        'این مدل از نیوبالانس برای دویدن در سطوح مختلف طراحی شده است. زیره بیرونی از فناوری N-Durance، ترکیب ویژه ای از لاستیک کربنی که دوام مواد را تضمین می کند، و آج AT استفاده می کند که به لطف آن، آج چسبندگی خوبی در فرودها و صعودها ایجاد می کند و از لغزش محافظت می کند. زیره میانی با تکنولوژی Fresh Foam ساخته شده است که به لطف آن سطح بالایی از بالشتک و پاسخگویی مناسب فوم را در قبال حرکات متنوع فراهم می کند. قسمت جلویی رویه با ماده ای تقویت شده است که از انگشتان پا در برابر برخورد به سنگ یا اجسام سفت محافظت می کند. این مدل از نیوبالانس به دونده اجازه می دهد از مسیرهای غیرقابل دسترس بالا برود.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('نظرات کاربران'),
                        TextButton(
                            onPressed: () {}, child: const Text('ثبت نظر'))
                      ],
                    ),
                  ),
                ]),
              ),
              CommentListView(productId: product.id),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 90,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
