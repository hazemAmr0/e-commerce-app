import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:e_commerce_app/screens/card/widgets/cart_item_widget.dart';
import 'package:e_commerce_app/screens/card/widgets/empty_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartItem {
  final String name;
  final double price;
  int quantity;

  CartItem({required this.name, required this.price, this.quantity = 1});
}

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


class TotalPriceWidget extends StatelessWidget {
  final double totalPrice;

  const TotalPriceWidget({Key? key, required this.totalPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartprovider=Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.green[800],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 RichText(
                    text: TextSpan(
                      text: 'No.of product : ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                     color: Colors.amber
                      ), // Default text style
                      children: <TextSpan>[
                        TextSpan(
                          text: '${cartprovider.getcart.length}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                 RichText(
                    text: TextSpan(
                      text: 'No.of items : ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        color:    Colors.amber,
                         ), // Default text style
                      children: <TextSpan>[
                        TextSpan(
                          text: '${cartprovider.totalItems()}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.amber),
                        ),
                      ],
                    ),
                  ),

                  RichText(
                    text: TextSpan(
                      text: 'Total price : ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber
                      ), // Default text style
                      children: <TextSpan>[
                        TextSpan(
                          text: '${totalPrice.toStringAsFixed(2)} \$',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[800],
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        'Check out',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 showRemoveAllItemsDialog(BuildContext context, CartProvider cartprovider) {
 return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove All Items'),
          content: Text('Are you sure you want to remove all items from your cart?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Remove'),
              onPressed: () {
                // Code to remove all items from the cart
                cartprovider.clearCart();
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
 }