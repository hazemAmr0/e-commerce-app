
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app/consts/widgets/empty_screen.dart';

import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/search/widgets/item_card.dart';
import 'package:e_commerce_app/screens/search/widgets/search_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key, this.categoryName,});

  late TextEditingController searchController=  TextEditingController();

  final String?categoryName;

  @override
  Widget build(BuildContext context) {
    
    final productProvider = Provider.of<ProductProvider>(context);
   List<ProductModel> CategoryList =categoryName==null?productProvider.getProducts: productProvider.productsByCategory(categoryName!); 

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
  icon: Icon(Icons.search),
  onPressed: () {
    showSearch(
      
      context: context,
      delegate: ProductSearchDelegate(categoryList: CategoryList), // Pass your category list here
    );
  },
),
        title:  Text(categoryName??'Search',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
        
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
       body: //CategoryList.isEmpty
          CategoryList.isEmpty?EmptyScreen(
              img: 'assets/images/emptybox.png',
              title1: 'No Products Found',
              title2: 'Please Check Later',
              title3: '',
            ):
            StreamBuilder<List<ProductModel>>(
             
              stream:productProvider.FetchproductsStream() ,
             builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.hasError){
                return Center(child: Text('Error: ${snapshot.error}'),);
              }
              if(snapshot.data==null){
                return Center(child: Text('No Products Found'),);
              } 
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: DynamicHeightGridView(builder: (context,index){
                        return  ItemCard(
                                productId: CategoryList[index].productId??'',
                        );
                        
                       
                      }, itemCount: CategoryList.length, crossAxisCount: 2),
                    ),
                  ],
                ),
              );}
            ),
    );
  }
}







