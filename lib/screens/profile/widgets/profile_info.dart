import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';

class Profileinfo extends StatelessWidget {
  const Profileinfo({
    super.key,
    required this.themeProvider,
  });

  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              shape: BoxShape.circle,
              image: const DecorationImage(
                  image: AssetImage('assets/images/profile1.png')),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'hazema amr',
                style: themeProvider.Isdark_theme
                    ? TextStyles.font16WhiteBold
                    : TextStyles.font16BlackBold,
              ),
              Text(
                'hazema amr@gmail.com',
                style: themeProvider.Isdark_theme
                    ? TextStyles.font14GrayRegular
                    : TextStyles.font14blackRegular,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
