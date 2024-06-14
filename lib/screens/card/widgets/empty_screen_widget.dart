import 'package:flutter/material.dart';

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
        SizedBox(
          height: 100,
        ),
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
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
                child: Text(
              'Go to Shopping',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ],
    );
  }
}
