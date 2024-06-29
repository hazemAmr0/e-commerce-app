import 'package:card_swiper/card_swiper.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/screens/home/widgets/banner_widget.dart';
import 'package:e_commerce_app/screens/home/widgets/categories_card.dart';
import 'package:e_commerce_app/screens/home/widgets/list_of_categories.dart';
import 'package:e_commerce_app/screens/search/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<String> banners = [
    'assets/images/banners/banner1.png',
    'assets/images/banners/banner2.png',
  ];

  @override
  Widget build(BuildContext context) {
    // Build the home screen widget.
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BannerWidget(banners: banners),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Categories',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Categories.categoriesName.length,
                  itemBuilder: (context, index) {
                    return CategoriesCard(
                      img: Categories.categoriesImage[index],
                      title: Categories.categoriesName[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Latest Products',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              DynamicHeightGridView(
                crossAxisCount: 2,
                itemCount: 4,
                shrinkWrap: true, // Added shrinkWrap
                physics: const NeverScrollableScrollPhysics(), // Added physics
                builder: (context, index) {
                  return ItemCard(
                    productId: 'iphone14-128gb-black',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
