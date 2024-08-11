

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/consts/choose_image_dialog.dart';
import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:e_commerce_app/consts/snackbar_messege.dart';
import 'package:e_commerce_app/screens/auth/services/Auth_sevices.dart';

import 'package:e_commerce_app/screens/auth/widgets/signup/form_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance;
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  // Focus Nodes
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  // Image Picker
  XFile? _pickedImage;
 String? imageUrl;
  // Password Visibility
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;
  bool isLoading = false;
  @override
  void dispose() {
    // Dispose controllers
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();

    // Dispose focus nodes
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _nameFocusNode.dispose();

    super.dispose();
  }
Future<void> _registerFct() async {
    final isValid = _formKey.currentState!.validate();
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please pick an image.')),
      );
      return;
    }
    if (isValid) {
      setState(() {
        isLoading = true;
      });

      FirebaseStorage storage = FirebaseStorage.instance;
      final Reference ref = storage
          .ref()
          .child('usersImages')
          .child('${_emailController.text.trim()}.jpg');
      await ref.putFile(File(_pickedImage!.path));
      imageUrl = await ref.getDownloadURL();

      _formKey.currentState!.save();
      String res = await AuthServices().signUp(
        context: context,
        email: _emailController.text.trim().toLowerCase(),
        password: _passwordController.text.trim(),
        username: _nameController.text.trim(),
        favorite: [],
        userCart: [],
        image: imageUrl ?? '',
        timestamp: Timestamp.now(),
      );

      if (res == 'user created') {
        setState(() {
          isLoading = false;
        });

        showCustomSnackBar(
          context,
          color: Colors.green,
          message: 'User created successfully',
        );

        Navigator.pushReplacementNamed(context,
            Routes.login); // Use pushReplacementNamed to avoid going back
      } else {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(res),
          ),
        );
      }
    }
  }


  Future<void> picimage() async {
    final ImagePicker _picker = ImagePicker();
    showChooseImageDialog(
        context: context,
        onCameraTap: () async {
          _pickedImage = await _picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        onGalleryTap: () async {
          _pickedImage = await _picker.pickImage(source: ImageSource.gallery);
          setState(() {});
        },
        onRemoveTap: () {
          setState(() {
            _pickedImage = null;
          });
        });
  }

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordObscured = !isPasswordObscured;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      isConfirmPasswordObscured = !isConfirmPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColor.tertiary,
      body:SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
children: [
    Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkScaffoldColor,
                    ),
                  ),
                ),
                  SizedBox(height: 50.h),
FormFields(
                  isLoading: isLoading,
                  formKey: _formKey,
                  emailController: _emailController,
                  nameController: _nameController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  emailFocusNode: _emailFocusNode,
                  nameFocusNode: _nameFocusNode,
                  passwordFocusNode: _passwordFocusNode,
                  confirmPasswordFocusNode: _confirmPasswordFocusNode,
                  isPasswordObscured: isPasswordObscured,
                  isConfirmPasswordObscured: isConfirmPasswordObscured,
                  togglePasswordVisibility: _togglePasswordVisibility,
                  toggleConfirmPasswordVisibility:
                      _toggleConfirmPasswordVisibility,
                  pickedImage: _pickedImage,
                  onCameraTap: picimage,
                  onRegisterTap: _registerFct,
                ),

],
            ),
          ),
        ), 
      
      ) ,
       
    );
  }
}

