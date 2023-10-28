// ignore_for_file: sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskplus/Theme/Dimensions.dart';
import 'package:taskplus/Theme/text_theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  final Color titleColor;
  final bool isLoading;
  final VoidCallback onPressed;

  CustomButton({
    Key? key, // Use Key? key instead of super.key
    required this.title,
    this.color = const Color.fromARGB(255, 26, 104, 67),
    required this.onPressed,
    this.titleColor = Colors.white,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeOverLarge),
      child: MaterialButton(
        height: 40,
        minWidth: double.infinity,
        onPressed: onPressed,
        child: isLoading == true
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text('Loding..')],
              )
            : Text(title, style: titleRegular),
        color: color,
        textColor: titleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(45),
        ),
      ),
    );
  }
}
