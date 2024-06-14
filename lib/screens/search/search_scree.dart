import 'dart:math';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/screens/search/widgets/item_card.dart';
import 'package:e_commerce_app/screens/search/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  late TextEditingController searchController;

  @override



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
       Search_Bar(searchController: searchController),
Expanded(
  child: DynamicHeightGridView(builder: (context,index){
    return ItemCard();
  }, itemCount: 8, crossAxisCount: 2),
)
          ],
        ),
      ),
    );
  }
}







