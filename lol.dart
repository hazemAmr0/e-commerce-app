// import 'package:e_commerce_app/consts/routting/routes.dart';
// import 'package:e_commerce_app/consts/widgets/loading_manager.dart';
// import 'package:e_commerce_app/consts/widgets/sucsses_login.dart';
// import 'package:e_commerce_app/screens/auth/services/Auth_sevices.dart';
// import 'package:e_commerce_app/screens/auth/widgets/Google_button.dart';
// import 'package:e_commerce_app/screens/auth/widgets/build_top_section.dart';
// import 'package:e_commerce_app/screens/auth/widgets/my_validators.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';

// import '../../consts/app_colors.dart';

// class Lol extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// //
// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final _emailController = TextEditingController();

//   final _passwordController = TextEditingController();

//   final FocusNode _emailFocusNode = FocusNode();

//   final FocusNode _passwordFocusNode = FocusNode();
//   bool obscureText = true;
//   bool isLoading = false;
//   final user = FirebaseAuth.instance;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _emailFocusNode.dispose();
//     _passwordFocusNode.dispose();
//     super.dispose();
//   }

//   Future<void> _loginFct() async {
//     final isValid = _formKey.currentState!.validate();
//     if (isValid) {
//       _formKey.currentState!.save();
//       // Handle registration logic here
//       String res = await AuthServices().signIn(_emailController.text.trim(),
//           _passwordController.text.trim(), context);
//       if (res == 'user Logged in successfully') {
//         setState(() {
//           isLoading = true;
//         });

//         Future.delayed(
//           Duration(seconds: 3),
//           () => showSuccessLoginAndNavigateToHome(
//             context,
//           ),
//         );
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: LoadingManager(
//         isLoading: isLoading,
//         child: Stack(
//           children: [
//             buildTopSection(
//               context: context,
//               title: 'Login',
//             ),
//             Positioned(
//               bottom: 0,
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height * 1.28,
//                 width: MediaQuery.of(context).size.width,
//                 child: Image.asset('assets/images/c3.png', fit: BoxFit.cover),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height * 1.35,
//                 width: MediaQuery.of(context).size.width,
//                 child: Image.asset('assets/images/c2.png', fit: BoxFit.cover),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               child: Stack(
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height * 1.44,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.transparent,
//                     child:
//                         Image.asset('assets/images/c1.png', fit: BoxFit.cover),
//                   ),
//                   Positioned(
//                       bottom: 30,
//                       left: 40,
//                       right: 40,
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Email ',
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                             const SizedBox(height: 10),
//                             TextFormField(
//                               controller: _emailController,
//                               focusNode: _emailFocusNode,
//                               textInputAction: TextInputAction.next,
//                               keyboardType: TextInputType.emailAddress,
//                               decoration: const InputDecoration(
//                                 filled: true,
//                                 fillColor: AppColor.backGroundForm,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(5),
//                                   ),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 hintText: "Email address",
//                                 prefixIcon: Icon(
//                                   IconlyLight.message,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               validator: (value) {
//                                 return MyValidators.emailValidator(value);
//                               },
//                               onFieldSubmitted: (value) {
//                                 FocusScope.of(context)
//                                     .requestFocus(_passwordFocusNode);
//                               },
//                             ),
//                             const SizedBox(height: 20),
//                             const Text(
//                               'Password',
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white),
//                             ),
//                             const SizedBox(height: 10),
//                             TextFormField(
//                               controller: _passwordController,
//                               focusNode: _passwordFocusNode,
//                               textInputAction: TextInputAction.done,
//                               keyboardType: TextInputType.visiblePassword,
//                               obscureText: obscureText,
//                               decoration: InputDecoration(
//                                 filled: true,
//                                 fillColor: AppColor.backGroundForm,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 hintText: "*********",
//                                 prefixIcon: const Icon(
//                                   IconlyLight.lock,
//                                   color: Colors.white,
//                                 ),
//                                 suffixIcon: IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       obscureText = !obscureText;
//                                     });
//                                   },
//                                   icon: Icon(
//                                     obscureText
//                                         ? Icons.visibility
//                                         : Icons.visibility_off,
//                                   ),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 return MyValidators.passwordValidator(value);
//                               },
//                               onFieldSubmitted: (value) {
//                                 //  _loginFct();
//                               },
//                             ),
//                             const SizedBox(height: 20),
//                             InkWell(
//                                 onTap: () {
//                                   Navigator.pushNamed(
//                                       context, Routes.forgetPassword);
//                                 },
//                                 focusColor: Colors.blue,
//                                 borderRadius: BorderRadius.circular(5),
//                                 child: const Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Text(
//                                       'Forgot Password?',
//                                       style: TextStyle(color: Colors.blue),
//                                     ))),
//                             const SizedBox(height: 30),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Center(
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       // Step 5: Trigger validation
//                                       _loginFct();
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor:
//                                           AppColor.loginButtonColor,
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 50, vertical: 10),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(30.0),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Log In',
//                                       style: TextStyle(
//                                           fontSize: 18, color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                                 const Text('or',
//                                     style: TextStyle(color: Colors.white)),
//                                 //       GoogleButton(),
//                                 GoogleButton(),
//                               ],
//                             ),
//                             const SizedBox(height: 25),
//                             Align(
//                                 alignment: Alignment.center,
//                                 child: GestureDetector(
//                                     onTap: () {
//                                       Navigator.pushNamed(
//                                           context, Routes.signUp);
//                                       _passwordController.clear();
//                                       _emailController.clear();
//                                     },
//                                     child: const Text(
//                                       'create new account?',
//                                       style: TextStyle(color: Colors.blue),
//                                     ))),
//                           ],
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
