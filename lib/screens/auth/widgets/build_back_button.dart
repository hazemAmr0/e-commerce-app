import 'package:flutter/material.dart';
class buildBackButton extends StatelessWidget {
  const buildBackButton({super.key, required this.context});
  final BuildContext context;
  @override
Widget build(BuildContext context) {

  return Row(
    children: [
     
      const Text('Back',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
    ],
  );
}
}