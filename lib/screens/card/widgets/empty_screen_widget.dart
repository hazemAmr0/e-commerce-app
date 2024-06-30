import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    required this.img,
    required this.title1,
    required this.title2,
    required this.title3,
  });
  final String img;
  final String title1;
  final String title2;
  final String title3;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          img,
          height: 200,
        ),
        SizedBox(
          height: 70,
        ),
        Text(
          title1,
          style: TextStyle(fontSize: 35),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            title2,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
        ),
        Text(
          title3,
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        SizedBox(
          height: 150,
        ),
        InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {},
            child: SizedBox(
              width: 300.w,
              child: TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 1, 160, 54)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, Routes.rootScreen);
                  }, icon: Icon(IconlyLight.buy), label: Text('Shop Now')),
            )),
      ],
    );
  }
}
