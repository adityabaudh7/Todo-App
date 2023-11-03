// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:taskplus/Auth/Controller/Auth_controller.dart';
import 'package:taskplus/Custom/Todo_Input_Text_Screen.dart';
import 'package:taskplus/Custom/Widget/Custom_Button.dart';
import 'package:taskplus/Custom/Widget/ShowCustomSnackbar.dart';
import 'package:taskplus/Screens/Error/Error_Screen.dart';
import 'package:taskplus/Theme/Animation/animation_plate.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/Dimensions.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  final String name;
  final String email;
  final String number;
  final String Password;
  final String? authId;
  const SignUpScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.number,
    required this.Password,
    this.authId,
  }) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  File? _imageFile;
  bool isLoading = false;

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    numberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.name != null &&
        widget.email != null &&
        widget.number != null &&
        widget.Password != null) {
      nameController.text = widget.name;
      emailController.text = widget.email;
      numberController.text = widget.number;
      passwordController.text = widget.Password;
    }
  }

  void StoreUserData() async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        try {
          setState(() {
            isLoading = true;
          });
          ref.read(authControllerProvider).saveDatatoFirebase(
              context,
              nameController.text,
              emailController.text,
              _imageFile,
              numberController.text,
              passwordController.text);
          showSnackBar(
              message: 'User register successfully',
              isError: false,
              isToaster: true);
          setState(() {
            isLoading = false;
          });
        } catch (e) {
          print(e);
        }
      } else {
        showSnackBar(
            message: 'Not Matched your confirm password!', isError: true);
      }
    }
  }

  void UpdateUserDetails() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text == confirmPasswordController.text) {
        ref.read(authControllerProvider).updateUser(
            context,
            nameController.text,
            emailController.text,
            _imageFile,
            numberController.text,
            passwordController.text);
        showSnackBar(
            message: 'User update successfully !',
            isError: false,
            isToaster: true);
        Get.back();
      } else {
        showSnackBar(
            message: 'Not Matched your confirm password!',
            isError: true,
            isToaster: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    return Scaffold(
        backgroundColor: darkMode ? ColorPalate.black2 : ColorPalate.WHITE,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: darkMode ? ColorPalate.black2 : ColorPalate.WHITE,
        ),
        body: Stack(
          children: [
            Positioned(
                bottom: -50,
                right: -80,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
                      shape: BoxShape.circle),
                  height: 200,
                  width: 200,
                )),
            Positioned(
                bottom: -50,
                right: 50,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
                      shape: BoxShape.circle),
                  height: 160,
                  width: 160,
                )),
            ListView(
              children: [
                const SizedBox(height: Dimensions.topSpace),
                Center(
                  child: Container(
                      height: 120.00,
                      width: double.infinity,
                      child: Lottie.asset(Motion.LOGIN)),
                ),
                const SizedBox(height: Dimensions.topSpace),
                Center(
                  child: Text(
                    widget.authId != null ? 'Udate Page' : 'Registration',
                    style: titleHeader,
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeLarge),
                        TextInputField(
                          prefixIcon: FontAwesomeIcons.user,
                          hintText: 'Enter Your Name',
                          label: 'Full Name',
                          controller: nameController,
                          inputType: TextInputType.text,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        TextInputField(
                          prefixIcon: FontAwesomeIcons.at,
                          controller: emailController,
                          hintText: 'Enter your email',
                          inputType: TextInputType.emailAddress,
                          label: 'Email Address',
                          isEmail: true,
                          isEnable: widget.authId != null ? false : true,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        TextInputField(
                          prefixIcon: FontAwesomeIcons.phone,
                          controller: numberController,
                          hintText: '+91 9174332621',
                          inputType: TextInputType.phone,
                          label: 'Number',
                          isPhone: true,
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        TextInputField(
                          prefixIcon: FontAwesomeIcons.lock,
                          obscureText: true,
                          isPassword: true,
                          controller: passwordController,
                          hintText: 'Create a password',
                          inputType: TextInputType.visiblePassword,
                          label: 'Password',
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        TextInputField(
                          prefixIcon: FontAwesomeIcons.lock,
                          obscureText: true,
                          isPassword: true,
                          controller: confirmPasswordController,
                          hintText: 'Confirm your password',
                          inputType: TextInputType.visiblePassword,
                          label: 'Confirm Password',
                        ),
                        const SizedBox(height: Dimensions.paddingSizeOverLarge),
                        CustomButton(
                            onPressed: () {
                              ref.watch(userDataAuthProvider).when(
                                    data: (user) {
                                      if (user == null) {
                                        isLoading = true;
                                        StoreUserData();
                                        print(0);
                                        isLoading = false;
                                      } else {
                                        isLoading = true;
                                        UpdateUserDetails();
                                        print('start');
                                        isLoading = false;
                                      }
                                    },
                                    error: (err, trace) {
                                      return ErrorScreen(
                                        error:
                                            'Error occurred. Please try again later. ${err.toString()}',
                                      );
                                    },
                                    loading: () => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                            },
                            isLoading: isLoading,
                            title: isLoading == true
                                ? 'loding..'
                                : widget.authId != null
                                    ? 'Update User'
                                    : 'Create User',
                            color: ColorPalate.ORANGE),
                      ],
                    ))
              ],
            ),
            Positioned(
                child: IconButton(
                    onPressed: () {
                      Get.back();
                      // Navigator.pop(context, true);
                      print(1);
                    },
                    icon: Icon(FontAwesomeIcons.arrowLeft))),
          ],
        ));
  }
}
