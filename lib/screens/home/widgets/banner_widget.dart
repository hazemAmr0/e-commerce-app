import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Swiper(
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            child: Image.asset(
              banners[index],
              fit: BoxFit.fill,
            ),
          );
        },
        itemCount: banners.length,
        pagination: const SwiperPagination(
          margin: EdgeInsets.all(10),
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            color: Colors.white,
            activeColor: Colors.red,
          ),
        ),
      ),
    );
  }
}
