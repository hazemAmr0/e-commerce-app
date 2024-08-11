import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:e_commerce_app/consts/routting/routes.dart';

import 'package:e_commerce_app/screens/auth/services/Auth_sevices.dart';
import 'package:e_commerce_app/screens/auth/services/google_auth.dart';
import 'package:e_commerce_app/screens/auth/widgets/my_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool obscureText = true;
  bool isLoading = false;
  final user = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

 Future<void> _loginFct() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });

      String res = await AuthServices().signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        context,
      );

      if (res == 'user Logged in successfully') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.green,
              content: Text('Logged in successfully')),
        );
        Navigator.pushReplacementNamed(
            context, Routes.rootScreen); // Ensure correct navigation
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res)),
        );
      }

      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> _googleSignIn() async {
    setState(() {
      isLoading = true;
    });

    try {
      final userCredential = await FirebaseServices().signInWithGoogle(context);
      if (userCredential != null) {
        Navigator.pushReplacementNamed(context, Routes.rootScreen);
      } else {
        print('Sign-in was cancelled or failed');
      }
    } catch (e) {
      print('Error during sign-in: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.tertiary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: PopScope(
            canPop: false,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: AppColor.darkScaffoldColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Center(child: Image.asset('assets/animation/buyit.png', scale: 3)),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              filled: true,
                              fillColor: Colors.white12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Email address",
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.white24,
                              ),
                            ),
                            validator: (value) => MyValidators.emailValidator(value),
                              style: const TextStyle(color: Colors.black),
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(_passwordFocusNode);
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: obscureText,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white12,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Password",
                              prefixIcon: const Icon(
                                IconlyLight.lock,
                                color: Colors.white24,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                                icon: Icon(
                                  color: Colors.white24,
                                  obscureText ? Icons.visibility : Icons.visibility_off,
                                ),
                              ),
                            ),
                            validator: (value) => MyValidators.passwordValidator(value),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.forgetPassword);
                      },
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  isLoading
                      ? const Center(
                          child:
                              CircularProgressIndicator(color: Colors.grey))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _loginFct,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(color: Colors.white60),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.signUp);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.blue[100], fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.white60,
                          thickness: 1,
                          endIndent: 10,
                          indent: 20,
                        ),
                      ),
                      Text(
                        'Or',
                        style: TextStyle(color: Colors.white60),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.white60,
                          thickness: 1,
                          indent: 10,
                          endIndent: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton.icon(
                      onPressed: _googleSignIn,
                      icon: Image.asset(
                        'assets/images/google.png',
                        scale: 2,
                      ),
                      label: const Text('Sign in with Google'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.red[700],
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
