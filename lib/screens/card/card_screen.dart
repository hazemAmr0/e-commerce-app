import 'package:e_commerce_app/screens/card/widgets/empty_screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  bool isempty = false;
  List<CartItem> cartItems = [
    CartItem(name: 'Nike Air Max 90', price: 220.0),
    CartItem(name: 'Adidas Ultraboost', price: 180.0),
    CartItem(name: 'Puma RS-X', price: 150.0),
    CartItem(name: 'New Balance 990', price: 200.0),
  ];

  @override
  Widget build(BuildContext context) {
    double totalPrice =
        cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

    return Scaffold(
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
              setState(() {
                cartItems.clear();
                isempty = true;
              });
            },
          ),
        ],
      ),
      body: isempty
          ? const EmptyScreen(
              img: 'assets/images/emptybox.png',
              title1: 'Your Cart is Empty',
              title2: 'Looks like you didn\'t add anything yet',
              title3: 'Shop Now',
            )
          : SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          cartItem: cartItems[index],
                          onQuantityChanged: (newQuantity) {
                            setState(() {
                              if (newQuantity > 0) {
                                cartItems[index].quantity = newQuantity;
                              } else {
                                cartItems.removeAt(index);
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                  TotalPriceWidget(totalPrice: totalPrice),
                ],
              ),
            ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final ValueChanged<int> onQuantityChanged;

  const CartItemWidget({
    Key? key,
    required this.cartItem,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        minVerticalPadding: 35,
        leading: Image.asset(
          'assets/images/categories/shoes.png',
          height: 100,
        ),
        title: Text(
          cartItem.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '\$${cartItem.price.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
            fontSize: 16,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                onQuantityChanged(cartItem.quantity - 1);
              },
            ),
            Text(cartItem.quantity.toString()),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                onQuantityChanged(cartItem.quantity + 1);
              },
            ),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 100,
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
                children: [
                  Text(
                    'Total price',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
