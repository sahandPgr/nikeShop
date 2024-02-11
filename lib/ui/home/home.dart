import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop/data/product.dart';
import 'package:nike_shop/data/repo/banner_repository.dart';
import 'package:nike_shop/data/repo/product_repository.dart';
import 'package:nike_shop/ui/home/bloc/home_bloc.dart';
import 'package:nike_shop/ui/product/product.dart';
import 'package:nike_shop/ui/widgets/banner_slider.dart';
import 'package:nike_shop/ui/widgets/exception_box.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBlock = HomeBloc(
            bannerReposity: bannerRepositry,
            productRepository: productRepository);
        homeBlock.add(HomeStarted());
        return homeBlock;
      },
      child: Scaffold(body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeSuccess) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Image.asset(
                        'assets/images/nike.webp',
                        height: 80,
                      );
                    case 2:
                      return BannerSlider(
                        banners: state.banners,
                      );
                    case 3:
                      return _ProductListViewHorizan(
                          products: state.latesProducts,
                          subText: 'جدیدترین',
                          onTap: () {});

                    case 4:
                      return _ProductListViewHorizan(
                          products: state.popularProducts,
                          subText: 'پربازدیدترین',
                          onTap: () {});

                    default:
                      return Container();
                  }
                },
              );
            } else if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return ExceptionBox(
                exception: state.exception,
                onPressd: () {
                  BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                },
              );
            } else {
              throw Exception('This state is not supported.');
            }
          },
        ),
      )),
    );
  }
}



class _ProductListViewHorizan extends StatelessWidget {
  final List<ProductItem> products;
  final String subText;
  final GestureTapCallback onTap;
  const _ProductListViewHorizan({
    required this.products,
    required this.subText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subText.toString(),
                style: themeData.textTheme.bodyLarge,
              ),
              TextButton(
                  onPressed: onTap,
                  child: Text(
                    'مشاهده همه',
                    style: themeData.textTheme.bodyLarge,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductBlock(product: product);
              }),
        ),
      ],
    );
  }
}
