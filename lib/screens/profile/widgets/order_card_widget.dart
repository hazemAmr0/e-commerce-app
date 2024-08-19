import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
   OrderCard({super.key, required this.order});
final OrderModel order;
  @override
  _OrderCardState createState() => _OrderCardState();
}
 
class _OrderCardState extends State<OrderCard> {
  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
     String formattedDate =
        DateFormat('dd MMM yyyy').format(widget.order.orderDate.toDate());
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.green,
          width:1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
            children: [
              Icon(Icons.receipt, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Text('Order ID: ${widget.order.orderId.characters.take(8).toString().toUpperCase()}'),
            ],
          ),
          const SizedBox(height: 8),
           Row(
            children: [
              Icon(Icons.calendar_month, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Text('Order Date: ${formattedDate}'),
            ],
          ),
          const SizedBox(height: 8),
           Row(
            children: [
              Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Text('Status: ${widget.order.status}'),
            ],
          ),
          const SizedBox(height: 8),
           Row(
            children: [
              Icon(Icons.attach_money, color: Colors.green, size: 20),
              SizedBox(width: 8),
              Text('Total Amount: \$${widget.order.totalPrice}'),
            ],
          ),
          if (isExpanded) ...[
            const SizedBox(height: 8),
             Row(
              children: [
                Icon(Icons.location_on, color: Colors.green, size: 20),
                SizedBox(width: 8),
                Text('Address: ${widget.order.address}'),
              ],
            ),
            const SizedBox(height: 8),
             Row(
              children: [
                Icon(Icons.shopping_cart, color: Colors.green, size: 20),
                SizedBox(width: 8),
                Text('Quantity: ${widget.order.quantity}' ),
              ],
            ),
              Row(
              children: [
                Icon(Icons.local_mall, color: Colors.green, size: 20),
                SizedBox(width: 8),
                Text('product: ${widget.order.ProductName}'),
              ],
            ),
              Row(
              children: [
                Icon(Icons.attach_money, color: Colors.green, size: 20),
                SizedBox(width: 8),
                Text('price: ${widget.order.price}'),
              ],
            ),
             Row(
              children: [
                Icon(Icons.person, color: Colors.green, size: 20),
                SizedBox(width: 8),
                Text('username: ${widget.order.userName}'),
              ],
            ),

          ],
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 30.h,
              child: TextButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(5.0),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  backgroundColor: MaterialStateProperty.all( Colors.black),
                ),
                onPressed: toggleExpanded,
                child: Text(isExpanded ? 'Show Less' : 'Show More',
                    style: const TextStyle(color: Colors.white, fontSize: 10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
