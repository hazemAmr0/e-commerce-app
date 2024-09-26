import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:e_commerce_app/consts/styles.dart';
import 'package:e_commerce_app/models/uaer_model.dart';
import 'package:e_commerce_app/providers/theme_provider.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:e_commerce_app/screens/profile/widgets/log_out_alert.dart';
import 'package:e_commerce_app/screens/profile/widgets/profile_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
   const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {
User? user=FirebaseAuth.instance.currentUser;
UserModel? userModel;
Future<void>FetchUserInfoo()async{
  if(user==null){
  return;
  }

  final userProvider =   Provider.of<UserProvider>(context, listen: false);
  try{
userModel=await userProvider.fetchUserInfo();
setState(() {
  
});
  }catch(e){
    setState(() {
      
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }
  }
@override
  void initState() {
  FetchUserInfoo();
    // TODO: implement initState
    super.initState();
   
  }


  

  @override
  Widget build(BuildContext context) {
    
   

    final themeProvider = Provider.of<ThemeProvider>(context);
    return userModel==null?const Center(child: CircularProgressIndicator()): Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading:   Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Container(
                  //color: Colors.black,
                  child:
                      Image.asset(height: 50.h, 'assets/animation/buyit.png'),
                ),
              ),
      ),
      body: Column(
        children: [
          Profileinfo(themeProvider: themeProvider, 
          email: userModel!.email, 
          name: userModel!.name ,
          image: userModel!.profilePic,
          ),
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
            onTap: () {
              Navigator.pushNamed(context, Routes.orders);
            },
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
            onTap: () {
              // sendOneSignalNotificatios.sendOneSignalNotification();
            },
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
          await  logOutAlert(context);
            
          
              
            },
          ),
        ],
      ),
    );
  }
}


