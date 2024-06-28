import 'package:e_commerce_app/screens/auth/widgets/build_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class buildTopSection extends StatelessWidget {
  const buildTopSection({super.key, required this.context, required this.title});
final BuildContext context;
final String title;

  @override

Widget build(BuildContext context) {
  return Positioned(
    top: 0,
    left: 0,
    child: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Image.asset('assets/images/cupper.png', fit: BoxFit.cover),
        ),
        Positioned(
          top: 80,
          left: 10,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
                            
               Text(
                title,
                style: TextStyle(
                  fontSize: 30, // Adjust the font size as needed
                  color: Colors.white, // Adjust the text color as needed
                  fontWeight:
                      FontWeight.bold, // Adjust the font weight as needed
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
