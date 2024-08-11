import 'package:flutter/material.dart';

Widget buildTopSection({required BuildContext context, required String title}) {
  return Container(
    padding: const EdgeInsets.only(top: 50.0, left: 20.0),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
