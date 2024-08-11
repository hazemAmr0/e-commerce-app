
import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:e_commerce_app/screens/auth/services/Auth_sevices.dart';
import 'package:e_commerce_app/screens/auth/widgets/my_validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  Future<void> _loginFct() async {
    //final isValid = _formKey.currentState!.validate();
    AuthServices().resetPassword(emailController.text.trim());
    showAboutDialog(context: context, children: [
      const Text('Check your email to reset your password'),

    ]
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: AppColor.darkScaffoldColor,
     backgroundColor: AppColor.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child:Column(
            children: [
              Container(

                child: Image.asset('assets/images/forgetpassword1.png'),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Forget Password',
                    style: TextStyle(
                      fontSize: 20, // Adjust the font size as needed
                      color: AppColor.black, // Adjust the text color as needed
                      fontWeight:
                          FontWeight.bold, // Adjust the font weight as needed
                    ),
                  ),
                ),


              ),

              
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: emailController,
                      
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          filled: true,
                        //  fillColor: Colors.black38,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Email address",
                          prefixIcon: Icon(
                            IconlyLight.message,
                            color: Colors.white,
                          ),
                        ),
                        validator: (value) {
                          return MyValidators.emailValidator(value);
                        },
                      
                      ),
                  ),
                )),
                     const SizedBox(height: 40),
          SizedBox(
            height:40,
            width: 300,
            child: TextButton.icon(
             style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.blue), // Button background color
                      foregroundColor:
                          MaterialStateProperty.all(Colors.white), // Text color
                 // Button padding
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        // Button shape
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                      ),
                    ),
                  
              onPressed: () {
              _loginFct();
            }, icon: const Icon(IconlyLight.send), label: const Text('Request link')),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
