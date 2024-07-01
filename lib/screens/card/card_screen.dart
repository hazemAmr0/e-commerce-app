import 'package:e_commerce_app/consts/seccess_alertdialog.dart';
import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/card/widgets/cart_item_widget.dart';
import 'package:e_commerce_app/screens/card/widgets/checkout%20widget.dart';
import 'package:e_commerce_app/screens/card/widgets/empty_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
class CardScreen extends StatefulWidget {
  CardScreen({Key? key}) : super(key: key);

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {


  @override
  Widget build(BuildContext context) {
    
      final cartprovider=Provider.of<CartProvider>(context);
     final productProvider = Provider.of<ProductProvider>(context);


    return cartprovider.getcart.isEmpty
        ? const EmptyScreen(
            img: 'assets/images/emptybox.png',
            title1: 'Your Cart is Empty',
            title2: 'Looks like you didn\'t add anything yet',
            title3: 'Shop Now',
          )
        :  Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
            showRemoveAllItemsDialog(
              context,
              cartprovider,
            
            );

            },
          ),
        ],
      ),
      body:SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount:cartprovider.getcart.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: cartprovider.getcart.values.toList().reversed.toList()[index],
                          child: CartItemWidget());
                         
                      },
                    ),
                  ),
                TotalPriceWidget(totalPrice: cartprovider.totalAmount(
                  productProvider: productProvider
                )),
                ],
              ),
            ),
    );
  }
}


