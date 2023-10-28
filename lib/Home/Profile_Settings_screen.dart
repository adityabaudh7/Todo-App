// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taskplus/Auth/Controller/Auth_controller.dart';
import 'package:taskplus/Auth/Todo_Sign_up_screen.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Dimensions.dart';
import 'package:taskplus/Theme/text_theme.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class ProfileSettingScreen extends ConsumerStatefulWidget {
  const ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileSettingScreen> createState() =>
      _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends ConsumerState<ProfileSettingScreen> {
  void toLogoutUser() async {
    ref.read(authControllerProvider).LogoutUser();
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(getUserData);
    final darkMode = ref.watch(darkModeProvider);
    return Scaffold(
      backgroundColor: darkMode
          ? ColorPalate.black2
          : ColorPalate.DARK_PRIMERY.withOpacity(0.1),
      body: Stack(
        children: [
          Positioned(
              bottom: -50,
              right: -80,
              child: Container(
                decoration: BoxDecoration(
                    color: ColorPalate.ORANGE.withOpacity(0.1),
                    shape: BoxShape.circle),
                height: 200,
                width: 200,
              )),
          Positioned(
              bottom: -50,
              right: 50,
              child: Container(
                decoration: BoxDecoration(
                    color: ColorPalate.ORANGE.withOpacity(0.1),
                    shape: BoxShape.circle),
                height: 160,
                width: 160,
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300.00,
                decoration: BoxDecoration(
                    color: darkMode
                        ? ColorPalate.black1
                        : ColorPalate.DARK_PRIMERY),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  // ref.read(darkModeProvider.notifier).state = !ref.read(darkModeProvider.notifier).state;
                  final isDarkMode = ref.read(darkModeProvider.notifier).state;
                  ref.read(darkModeProvider.notifier).state = !isDarkMode;
                  // DarkModePreferences.setDarkMode(!isDarkMode);
                },
                child: ListTile(
                    title: Text('Dark Mode', style: titleRegular),
                    leading: Icon(FontAwesomeIcons.circleHalfStroke, size: 20)),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('FAQ', style: titleRegular),
                    leading: Icon(FontAwesomeIcons.questionCircle, size: 20)),
              ),
              InkWell(
                onTap: () {},
                child: ListTile(
                    title: Text('App Info', style: titleRegular),
                    leading: Icon(FontAwesomeIcons.circleInfo, size: 20)),
              ),
              InkWell(
                onTap: () {
                  toLogoutUser();
                },
                child: ListTile(
                    title: Text('Logout', style: titleRegular),
                    leading: Icon(FontAwesomeIcons.powerOff,
                        size: 20, color: ColorPalate.RED)),
              ),
              Spacer(),
              Text(
                'Version : 1.1',
                style: titilliumRegular,
              ),
              SizedBox(height: 18)
            ],
          ),
          Positioned(
              top: 90,
              right: 30,
              left: 30,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: darkMode
                      ? [
                          BoxShadow(
                            offset: Offset(2, 1),
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurStyle: BlurStyle.normal,
                            blurRadius: 10,
                          )
                        ]
                      : [],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Card(
                  color: darkMode ? ColorPalate.BLACK : ColorPalate.PRIMERY,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      width: 0.5,
                      color: darkMode ? Colors.white : Colors.transparent,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeLarge,
                        horizontal: Dimensions.paddingSizeExtraLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        userData.value == null
                            ? Container(
                                margin: EdgeInsets.only(left: 15),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorPalate.YELLOWTODO,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: ColorPalate.WHITE,
                                ),
                              )
                            : Stack(
                                children: [
                                  Container(
                                    // margin: const EdgeInsets.all(3.7),
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                userData.value!.profilePic),
                                            fit: BoxFit.cover),
                                        border: Border.all(
                                            width: 3, color: ColorPalate.WHITE),
                                        shape: BoxShape.circle,
                                        color:
                                            ColorPalate.GREY.withOpacity(0.1)),
                                  ),
                                  Positioned(
                                      bottom: 6,
                                      right: 10,
                                      child: InkWell(
                                          onTap: () {
                                            print('1');
                                          },
                                          child: Icon(FontAwesomeIcons.edit,
                                              color: darkMode
                                                  ? ColorPalate.DARK_PRIMERY
                                                  : ColorPalate.BLACK,
                                              size: 10))),
                                ],
                              ),
                        userData.value != null
                            ? Text(
                                'Hi! ${userData.value!.name}',
                                style: titleHeaderLarge.copyWith(
                                    fontFamily: 'shipro',
                                    fontWeight: FontWeight.w500),
                              )
                            : Text('Hi! User',
                                style: titleHeaderLarge.copyWith(
                                    fontFamily: 'shipro',
                                    fontWeight: FontWeight.w500)),
                        SizedBox(height: Dimensions.paddingSizeSmall),
                        userData.value != null
                            ? Text(
                                '${userData.value!.email}',
                                style: titleHeader.copyWith(
                                    fontWeight: FontWeight.w400),
                              )
                            : Text('email@gmail.com',
                                style: titleHeader.copyWith(
                                    fontWeight: FontWeight.w400)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            userData.value != null
                                ? Text(
                                    '${userData.value!.phoneNumber}',
                                    style: titleHeader.copyWith(
                                        fontFamily: 'shipro',
                                        fontSize: Dimensions.fontSizeExtraLarge,
                                        fontWeight: FontWeight.w500),
                                  )
                                : Text('+918896325262',
                                    style: titleHeader.copyWith(
                                        fontWeight: FontWeight.w400)),
                            IconButton(
                                onPressed: () {
                                  print('Aditya');
                                  Get.to(SignUpScreen(
                                    name: userData.value!.name,
                                    Password: userData.value!.password,
                                    email: userData.value!.email,
                                    number: userData.value!.phoneNumber,
                                  ));
                                },
                                icon: Icon(
                                  FontAwesomeIcons.edit,
                                  size: 15,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
