import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:e_commerce_app/screens/auth/widgets/my_validators.dart';
import 'package:e_commerce_app/screens/auth/widgets/pic_image.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class FormFields extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final FocusNode emailFocusNode;
  final FocusNode nameFocusNode;
  final FocusNode passwordFocusNode;
  final FocusNode confirmPasswordFocusNode;
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;
  final Function togglePasswordVisibility;
  final Function toggleConfirmPasswordVisibility;
  final XFile? pickedImage;
  final Function onCameraTap;
  final VoidCallback onRegisterTap;
  bool isLoading;

  FormFields({
    required this.isLoading,
    required this.formKey,
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.emailFocusNode,
    required this.nameFocusNode,
    required this.passwordFocusNode,
    required this.confirmPasswordFocusNode,
    required this.isPasswordObscured,
    required this.isConfirmPasswordObscured,
    required this.togglePasswordVisibility,
    required this.toggleConfirmPasswordVisibility,
    required this.pickedImage,
    required this.onCameraTap,
    required this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          PicImage(
            pickedImage: pickedImage,
            onCameraTap: onCameraTap,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: emailController,
              focusNode: emailFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true,
                 fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide.none,
                ),
                hintText: "Email address",
                prefixIcon: Icon(IconlyLight.message, color: Colors.white24,
                ),
                
              ),
              validator: (value) {
                return MyValidators.emailValidator(value);
              },
              style: TextStyle(color: Colors.black),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(nameFocusNode);
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: nameController,
              focusNode: nameFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide.none,
                ),
                hintText: "Name",
                prefixIcon: Icon(IconlyLight.profile,
                  color: Colors.white24,
                ),
              ),
              validator: (value) {
                return MyValidators.displayNamevalidator(value);
              },
              style: TextStyle(color: Colors.black),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(passwordFocusNode);
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              obscureText: isPasswordObscured,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Password',
                
                prefixIcon: const Icon(IconlyLight.lock, color: Colors.white24,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    togglePasswordVisibility();
                  },
                  icon: Icon(
                    isPasswordObscured ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              style: TextStyle(color: Colors.black),
              validator: (value) {
                return MyValidators.passwordValidator(value);
              },
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .09,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: confirmPasswordController,
                focusNode: confirmPasswordFocusNode,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                obscureText: isConfirmPasswordObscured,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Confirm password',
                  prefixIcon: const Icon(IconlyLight.lock, color: Colors.white24,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      toggleConfirmPasswordVisibility();
                    },
                    icon: Icon(
                      isConfirmPasswordObscured
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.black),
                validator: (value) {
                  return MyValidators.repeatPasswordValidator(
                    value: value,
                    password: passwordController.text,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          isLoading
              ? Center(
                  child: const CircularProgressIndicator(color: Colors.grey))
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: onRegisterTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
