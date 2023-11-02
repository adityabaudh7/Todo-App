// ignore_for_file: unused_import, prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:taskplus/BordingScreens/Content_Bording.dart';
import 'package:taskplus/Dashboard/Todo_Dashboard.dart';
import 'package:taskplus/Home/Todo_HomeScreen.dart';
import 'package:taskplus/Screens/Todo_Welcome_Screen.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';
import 'package:taskplus/main.dart';

class Boarding_Screen extends ConsumerStatefulWidget {
  const Boarding_Screen({super.key});

  @override
  ConsumerState<Boarding_Screen> createState() => _Boarding_ScreenState();
}

class _Boarding_ScreenState extends ConsumerState<Boarding_Screen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    return Scaffold(
      backgroundColor: darkMode ? ColorPalate.black2 : ColorPalate.WHITE,
      appBar: AppBar(
        backgroundColor:
            darkMode ? ColorPalate.BLACK : ColorPalate.DARK_PRIMERY,
        elevation: 0,
        centerTitle: true,
        title: Text('TaskPlus',
            style: titleHeader.copyWith(color: ColorPalate.WHITE)),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                            height: 310.00,
                            width: double.infinity,
                            child: Lottie.asset(contents[index].image)),
                      ),
                      Spacer(),
                      Text(contents[index].title, style: titleHeader),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        contents[index].discription,
                        textAlign: TextAlign.justify,
                        style: titilliumRegular,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  contents.length, (index) => buildDot(index, context)),
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.all(40),
            width: double.infinity,
            child: MaterialButton(
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                }
                _controller.nextPage(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.bounceIn);
              },
              child: Text(
                currentIndex == contents.length - 1 ? 'Continue' : 'Next',
                style: titleHeader,
              ),
              color: darkMode ? ColorPalate.BLACK : ColorPalate.DARK_PRIMERY,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorPalate.DARK_PRIMERY),
    );
  }
}
