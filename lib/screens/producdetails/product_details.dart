import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: ProductDetail(),
    );
  }
}
class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/shoes.png', // Replace with your image URL
                height: 170.0.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16.0.h),
          Text(
            'Hooded Sweatshirt',
            style: TextStyle(
              fontSize: 24.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'by Jarvis Pepperspray',
            style: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.0.h),
          Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$125.00',
                style: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(width: 8.0.w),
             
              IconButton(onPressed: (){}, icon: Icon(IconlyLight.heart), color: Colors.red),
            ],
          ),
          SizedBox(height: 16.0.h),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0.h),
          Text(
            ' tellusMauris neque tellusMauris neque tellusMauris neque tellusMauris neque tellusMauris neque tellusMauris neque tellusMauris neque tellusMauris neque tellus, placerat sit amet quam et, facilisis suscipit dui. Cras a pretium ena mauris. Mauris eget sapien ut nisi posuere.',
            style: TextStyle(fontSize: 16.0.sp),
          ),
          Spacer(),
          Center(
            child: SizedBox(
              width: double.infinity,
              height: 50.0.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber, // Background color
                ),
                child: Text(
                  'Add To Cart',
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
