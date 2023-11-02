// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/Dimensions.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class CustomePosterCard extends ConsumerWidget {
  final String quot;
  final String? auther;
  final String image;
  const CustomePosterCard(
      {Key? key, required this.quot, this.auther, required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: darkMode ? ColorPalate.BLACK : ColorPalate.WHITE,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall),
                width: 200,
                child: Text(
                  '"${quot}"',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: titilliumRegular,
                ),
              ),
              SizedBox(height: 5),
              Text(
                '- $auther',
                style: titleRegular.copyWith(fontStyle: FontStyle.italic),
              )
            ],
          ),
          Image.network(height: 90, width: 90, image)
        ],
      ),
    );
  }
}
