// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:taskplus/Auth/Todo_Sign_in_screen.dart';
import 'package:taskplus/Auth/Todo_Sign_up_screen.dart';
import 'package:taskplus/Custom/Widget/Custom_Button.dart';
import 'package:taskplus/Theme/Animation/animation_plate.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/Dimensions.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    return Scaffold(
        backgroundColor: darkMode ? ColorPalate.black2 : ColorPalate.WHITE,
        appBar: AppBar(
          // title: Text('WelcomeScreen'),
          toolbarHeight: 0,
          backgroundColor: darkMode ? ColorPalate.black2 : ColorPalate.WHITE,
        ),
        body: Stack(
          children: [
            // Positioned(
            //     bottom: -100,
            //     right: -50,
            //     child: Container(
            //       decoration: BoxDecoration(
            //           color: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
            //           shape: BoxShape.circle),
            //       height: 300,
            //       width: 300,
            //     )),
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

            Column(
              children: [
                const SizedBox(height: Dimensions.topSpace),
                Center(
                  child: Container(
                      height: 400.00,
                      width: double.infinity,
                      child: Lottie.asset(Motion.WELCOME)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeLarge)
                      .copyWith(top: Dimensions.paddingSizeLarge),
                  child: Text(
                    'Welcome to TaskPlus To-Do',
                    style: titleHeader.copyWith(
                        fontSize: Dimensions.fontSizeExtraLarge),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeLarge),
                  child: Text(
                    'Manage your life ',
                    style: titleRegular.copyWith(color: ColorPalate.GREY),
                  ),
                ),
                const Spacer(),
                CustomButton(
                    onPressed: () {
                      print('1');
                      Get.to(SignUpScreen(
                        number: '',
                        Password: '',
                        email: '',
                        name: '',
                      ));
                    },
                    title: 'Sign Up',
                    color: ColorPalate.ORANGE),
                const SizedBox(height: Dimensions.fontSizeExtraSmall),
                CustomButton(
                    title: 'Sign In',
                    onPressed: () {
                      print("2");
                      Get.to(SignInScreen());
                    }),
                const SizedBox(height: Dimensions.topSpace),
              ],
            ),
          ],
        ));
  }
}
