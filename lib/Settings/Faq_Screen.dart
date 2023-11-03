// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';
import 'services/Model/Faq_Content_Model.dart';

class FaqScreens extends ConsumerWidget {
  const FaqScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    return Scaffold(
        backgroundColor: darkMode ? ColorPalate.black2 : ColorPalate.WHITE,
        appBar: AppBar(
          title: Text(
            'Faq',
            style: titleHeader,
          ),
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
                bottom: -80,
                right: 50,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
                      shape: BoxShape.circle),
                  height: 160,
                  width: 160,
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: faqContent.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(faqContent[index].question, style: titleRegular),
                      const SizedBox(height: 3),
                      Text(
                        faqContent[index].answers,
                        style: titilliumRegular,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }
}
