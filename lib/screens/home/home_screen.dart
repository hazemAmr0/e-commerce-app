import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/screens/home/widgets/banner_widget.dart';
import 'package:e_commerce_app/screens/home/widgets/categories_card.dart';
import 'package:e_commerce_app/screens/home/widgets/list_of_categories.dart';
import 'package:e_commerce_app/screens/search/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> banners = [
    'assets/images/banners/banner1.png',
    'assets/images/banners/banner2.png',
  ] ; 

  @override
  Widget build(BuildContext context) {
    final productprovider=Provider.of<ProductProvider>(context);
  final userProvider=Provider.of<UserProvider>(context);

    // Build the home screen widget.
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Container(
               
                height: 100.h,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                         padding: const EdgeInsets.only(top: 10,left: 10),
                          child: Container(
                            //color: Colors.black,
                            child: Image.asset(
                              height: 50.h,
                              'assets/animation/buyit.png'),
                          ),
                        ),
                        const Spacer(), // This will push the following widgets to the right
                     Padding(
                          padding: const EdgeInsets.only(top: 10, right: 5),
                          child: Consumer<UserProvider>(
                            builder: (context, userProvider, child) {
                              return userProvider.getUser?.profilePic != null
                                  ?GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, Routes.profile);
                                    },
                                    child: CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                            userProvider.getUser!.profilePic!),
                                      ),
                                  )
                                  : CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.grey,
                                      child: Icon(Icons.person),
                                    );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                          child:  CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.brown.shade300,
                              child: Icon(Icons.notifications,color: Colors.black,),
                            
                            )
                        ),
                      ],
                    ),
               
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: BannerWidget(banners: banners),
              ),
              const SizedBox(height: 3),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 2),
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
                  'popular items',
                  style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              StreamBuilder<List<ProductModel>>(
                stream: productprovider.FetchproductsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  return DynamicHeightGridView(
                    crossAxisCount: 2,
                    itemCount: productprovider.getProducts.length > 4? 4: productprovider.getProducts.length  ,
                    shrinkWrap: true, // Added shrinkWrap
                    physics: const NeverScrollableScrollPhysics(), // Added physics
                    builder: (context, index) {
                      return ItemCard(
                        productId: productprovider.getProducts[index].productId!,
                      );
                    },
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
