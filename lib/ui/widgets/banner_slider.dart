import 'package:flutter/material.dart';
import 'package:nike_shop/data/banner.dart';
import 'package:nike_shop/ui/widgets/image_service.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final List<BannerEntity> banners;

  BannerSlider({
    super.key,
    required this.banners,
  });

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Stack(children: [
        PageView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: banners.length,
            controller: _controller,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ImageLoadingService(
                  imageurl: banners[index].imageUrl,
                ),
              );
            }),
        Positioned(
          bottom: 6,
          left: 0,
          right: 0,
          child: Center(
            child: SmoothPageIndicator(
              controller: _controller,
              count: banners.length,
              axisDirection: Axis.horizontal,
              effect: const SlideEffect(
                  spacing: 8.0,
                  radius: 2.0,
                  dotWidth: 16.0,
                  dotHeight: 4.0,
                  paintStyle: PaintingStyle.fill,
                  strokeWidth: 1.5,
                  dotColor: Colors.white70,
                  activeDotColor: Colors.white),
            ),
          ),
        )
      ]),
    );
  }
}
