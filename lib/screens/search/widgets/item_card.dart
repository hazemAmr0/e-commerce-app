import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:e_commerce_app/consts/seccess_alertdialog.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCard extends StatelessWidget {
  ItemCard({this.img, this.title, this.price});
String? img;
String? title;
String? price;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.pushNamed(context, Routes.productDetails);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200.w,
          decoration: BoxDecoration(
            color: themeProvider.Isdark_theme
                ? AppColor.cardcolordark
                : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: themeProvider.Isdark_theme
                          ? AppColor.darkPrimary
                          : Colors.blue[50],
                    ),
                    child: Center(
                      child: Image.asset(
                        img!,
                        height: 100,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Icon(
                      IconlyBold.heart,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      price!,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 11.sp),
                        Icon(Icons.star, color: Colors.amber, size: 11.sp),
                        Icon(Icons.star, color: Colors.amber, size: 11.sp),
                        Icon(Icons.star, color: Colors.amber, size: 11.sp),
                        Icon(Icons.star_border, color: Colors.amber, size: 11.sp),
                        SizedBox(width: 5),
                        Text(
                          '(3.0)',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showSuccessDialog(context);
                          },
                          icon: Icon(IconlyBold.bag2,),
                          color: Colors.blue,
                          
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
