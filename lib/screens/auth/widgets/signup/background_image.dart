import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.7,
      width: MediaQuery.of(context).size.width,
      child: Image.asset('assets/images/c1.png', fit: BoxFit.cover),
    );
  }
}
