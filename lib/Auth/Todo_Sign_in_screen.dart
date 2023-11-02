// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:taskplus/Auth/Controller/Auth_controller.dart';
import 'package:taskplus/Custom/Todo_Input_Text_Screen.dart';
import 'package:taskplus/Custom/Widget/Custom_Button.dart';
import 'package:taskplus/Theme/Animation/animation_plate.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/Dimensions.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';

class SignInScreen extends ConsumerStatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void toSignInUser() async {
    if (_formKey.currentState!.validate()) {
      ref.read(authControllerProvider).signINWithEmail(
          context: context,
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPalate.WHITE,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: ColorPalate.WHITE,
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
                const SizedBox(height: Dimensions.supertopSpace),
                Center(
                  child: Text(
                    'Welcome Back !',
                    style: titleHeaderLarge,
                  ),
                ),
                Center(
                  child: Container(
                      height: 300.00,
                      width: double.infinity,
                      child: Lottie.asset(Motion.Password)),
                ),
                const SizedBox(height: Dimensions.topSpace),

                // Text(
                //   'Hi, Welcome Back',
                //   style: titleRegular,
                // ),
                const SizedBox(height: Dimensions.supertopSpace),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextInputField(
                          prefixIcon: FontAwesomeIcons.at,
                          controller: emailController,
                          hintText: 'Enter your email',
                          inputType: TextInputType.emailAddress,
                          label: 'Email Address',
                          isEmail: true,
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
                        const SizedBox(height: Dimensions.paddingSizeOverLarge),
                        CustomButton(
                            onPressed: () {
                              toSignInUser();
                            },
                            title: 'Submit',
                            color: ColorPalate.ORANGE),
                      ],
                    ))
              ],
            ),
            Positioned(
                child: IconButton(
                    onPressed: () {
                      Get.back();
                      print(1);
                    },
                    icon: Icon(FontAwesomeIcons.arrowLeft))),
          ],
        ));
  }
}
