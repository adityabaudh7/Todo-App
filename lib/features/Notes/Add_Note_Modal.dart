// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/Custom/Todo_Input_Text_Screen.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Dimensions.dart';
import 'package:taskplus/Theme/text_theme.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class AddNoteModal extends ConsumerWidget {
  AddNoteModal({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _disTitleController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: darkMode
                ? ColorPalate.black2
                : ColorPalate.DARK_PRIMERY.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: Dimensions.paddingSizeExtraLarge),
          Container(
              width: double.infinity,
              child: Text('New Sticky Notes',
                  textAlign: TextAlign.center, style: titleHeader)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Divider(
              thickness: 1.2,
              color: Colors.grey[200],
            ),
          ),
          SizedBox(height: Dimensions.fontSizeSmall),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: Dimensions.homePagePadding),
                  TextInputField(
                    controller: _noteTitleController,
                    hintText: 'Enter your note title',
                    inputType: TextInputType.text,
                    label: 'Title',
                    radius: 8.0,
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault),
                  TextInputField(
                    controller: _disTitleController,
                    hintText: 'Enter your notes',
                    inputType: TextInputType.multiline,
                    label: 'Notes',
                    radius: 8.0,
                    maxLines: 4,
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault),
                ],
              ))
        ]));
  }
}
