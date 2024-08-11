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
      height: 180,
      child: Swiper(
        curve: Curves.fastOutSlowIn,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              
              banners[index],
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: banners.length,
        pagination: const SwiperPagination(
          
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
