import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:flutter/material.dart';

class Profileinfo extends StatelessWidget {
  const Profileinfo({
    super.key,
    required this.themeProvider, required this.name, required this.email, required this.image,
  });
final String name;
final String email;
final String image;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
         SizedBox(
          height: 60,
          width: 60,
           child: ClipRRect(
             borderRadius: BorderRadius.circular(10.0),
             child: Image.network(image,fit: BoxFit.cover,),
             ),
         ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: themeProvider.Isdark_theme
                    ? TextStyles.font16WhiteBold
                    : TextStyles.font16BlackBold,
              ),
              Text(
                email,
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
