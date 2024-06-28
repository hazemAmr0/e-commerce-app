import 'package:e_commerce_app/consts/app_colors.dart';
import 'package:e_commerce_app/consts/choose_image_dialog.dart';
import 'package:e_commerce_app/consts/routting/routes.dart';
import 'package:e_commerce_app/screens/auth/widgets/build_top_section.dart';
import 'package:e_commerce_app/screens/auth/widgets/my_validators.dart';
import 'package:e_commerce_app/screens/auth/widgets/pic_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

// Password Visibility
  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  @override
  void initState() {
    super.initState();
    // Consider if listeners are necessary; if so, ensure they're used effectively.
  }

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
    if(isValid){
      if (_pickedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please pick an image'),
          ),
        );
        return;
      }
      Navigator.pushNamed(context, Routes.rootScreen);
    }
    print('objectkkkkkkkkkkkkkhvjvf');
  }

  Future<void> picimage() async {
    final ImagePicker _picker = ImagePicker();
    showChooseImageDialog(
        context: context,
        onCameraTap: ()async {
      
_pickedImage= await _picker.pickImage(source: ImageSource.camera);
          setState(() {});
        },
        onGalleryTap: ()async {
          _pickedImage = await _picker.pickImage(source: ImageSource.gallery);
            setState(() {});
        },
        
        onRemoveTap: () {
         
          setState(() {
             _pickedImage = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          buildTopSection(context: context, title: 'Sign Up'),
          Positioned(
            bottom: 0,
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 1.7,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset('assets/images/c1.png',
                          fit: BoxFit.cover),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 40,
                      right: 40,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            PicImage(
                              pickedImage: _pickedImage,
                              onCameraTap: () {
                                picimage();
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _emailController,
                              focusNode: _emailFocusNode,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: AppColor.backGroundForm,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
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
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _nameController,
                              focusNode: _nameFocusNode,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: AppColor.backGroundForm,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "name",
                                prefixIcon: Icon(
                                  IconlyLight.profile,
                                  color: Colors.white,
                                ),
                              ),
                              validator: (value) {
                                return MyValidators.displayNamevalidator(value);
                              },
                              onFieldSubmitted: (value) {
                                FocusScope.of(context)
                                    .requestFocus(_passwordFocusNode);
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              focusNode: _passwordFocusNode,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: isPasswordObscured,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColor.backGroundForm,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "*********",
                                prefixIcon: const Icon(
                                  IconlyLight.lock,
                                  color: Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPasswordObscured = !isPasswordObscured;
                                    });
                                  },
                                  icon: Icon(
                                    isPasswordObscured
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                return MyValidators.passwordValidator(value);
                              },
                              onFieldSubmitted: (value) {
                                //  _loginFct();
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * .09,
                              child: TextFormField(
                                controller: _confirmPasswordController,
                                focusNode: _confirmPasswordFocusNode,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: isConfirmPasswordObscured,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: AppColor.backGroundForm,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'confirm password',
                                  prefixIcon: const Icon(
                                    IconlyLight.lock,
                                    color: Colors.white,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isConfirmPasswordObscured = !isConfirmPasswordObscured;
                                      });
                                    },
                                    icon: Icon(
                                      isConfirmPasswordObscured
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  return MyValidators.repeatPasswordValidator(
                                      value: value,
                                      password: _passwordController.text);
                                },
                                onFieldSubmitted: (value) {
                                  //  _loginFct();
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                print('fffffffffffffffffffffffffff');
                                // Step 5: Trigger validation
                                _registerFct();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.loginButtonColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 730,
                      left: 30,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _emailController.clear();
                          _passwordController.clear();
                          _nameController.clear();
                          _confirmPasswordController.clear();
                        },
                        child: const Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            Text(
                              'Back',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
