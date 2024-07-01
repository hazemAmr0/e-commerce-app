import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/screens/profile/widgets/log_out_alert.dart';
import 'package:e_commerce_app/screens/profile/widgets/profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Image.asset('assets/images/bag/shopping_cart.png'),
      ),
      body: Column(
        children: [
          Profileinfo(themeProvider: themeProvider),
          const SizedBox(height: 40),
          SwitchListTile(
            title:
                Text(themeProvider.Isdark_theme ? 'Dark Theme' : 'Light Theme'),
            value: themeProvider.Isdark_theme,
            onChanged: (value) {
              themeProvider.setdarkTheme(value: value);
            },
          ),
          ListTile(
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              'Orders',
              style: themeProvider.Isdark_theme
                  ? TextStyles.font16WhiteBold
                  : TextStyles.font16BlackBold,
            ),
            leading: Image.asset(
              'assets/images/bag/order_svg.png',
              height: 30,
            ),
            onTap: () {},
          ),
          const SizedBox(height: 20),
          ListTile(
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              'favorite',
              style: themeProvider.Isdark_theme
                  ? TextStyles.font16WhiteBold
                  : TextStyles.font16BlackBold,
            ),
            leading: Image.asset(
              'assets/images/bag/wishlist_svg.png',
              height: 30,
            ),
            onTap: () {
              Navigator.pushNamed(context, Routes.favorites);
            },
          ),
          const SizedBox(height: 20),
          // ListTile(
          //   trailing: const Icon(Icons.chevron_right),
          //   title: Text(
          //     'viewed ',
          //     style: themeProvider.Isdark_theme
          //         ? TextStyles.font16WhiteBold
          //         : TextStyles.font16BlackBold,
          //   ),
          //   leading: Image.asset(
          //     'assets/images/profile/recent.png',
          //     height: 30,
          //   ),
          //   onTap: () {
          //     Navigator.pushNamed(context, Routes.viewed);
          //   },
          // ),
         
          ListTile(
            trailing: const Icon(Icons.chevron_right),
            title: Text(
              'address ',
              style: themeProvider.Isdark_theme
                  ? TextStyles.font16WhiteBold
                  : TextStyles.font16BlackBold,
            ),
            leading: Image.asset(
              'assets/images/profile/address.png',
              height: 30,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Logout ',
              style: themeProvider.Isdark_theme
                  ? TextStyles.font16WhiteBold.copyWith(color: Colors.red)
                  : TextStyles.font16BlackBold.copyWith(color: Colors.red),
            ),
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            onTap: ()async {
          await  LogourAlert(context);
          Navigator.pushNamed(context, Routes.login);
              
            },
          ),
        ],
      ),
    );
  }

 
}


