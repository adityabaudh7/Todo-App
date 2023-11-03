// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class DateTimeWidget extends ConsumerWidget {
  final String titleText;
  final String valueText;
  final IconData icon;
  final VoidCallback isSelected;
  final bool isOptional;
  const DateTimeWidget({
    Key? key,
    required this.titleText,
    required this.valueText,
    required this.icon,
    required this.isSelected,
    this.isOptional = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                titleText,
                style: titleRegular,
              ),
              isOptional
                  ? Text(
                      ' (Optional)',
                      style: titilliumRegular.copyWith(color: ColorPalate.RED),
                    )
                  : Text('')
            ],
          ),
          SizedBox(height: 5.0),
          Ink(
            decoration: BoxDecoration(
                // color: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: isSelected,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 0.8, color: ColorPalate.DARK_PRIMERY),
                    color: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(valueText),
                    SizedBox(width: 8),
                    Icon(
                      icon,
                      color: ColorPalate.DARK_PRIMERY.withOpacity(0.5),
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
