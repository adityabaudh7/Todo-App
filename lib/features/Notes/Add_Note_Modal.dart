// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskplus/Custom/Todo_Input_Text_Screen.dart';
import 'package:taskplus/Custom/Widget/Custom_Button.dart';
import 'package:taskplus/Custom/Widget/ShowCustomSnackbar.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Dimensions.dart';
import 'package:taskplus/Theme/text_theme.dart';
import 'package:taskplus/features/Notes/Model/S_Notes_Model.dart';
import 'package:taskplus/features/Notes/Provider/Note_Repo_Provider.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class AddNoteModal extends ConsumerStatefulWidget {
  const AddNoteModal({Key? key}) : super(key: key);

  @override
  ConsumerState<AddNoteModal> createState() => _AddNoteModalState();
}

class _AddNoteModalState extends ConsumerState<AddNoteModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _disTitleController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode disFocusNode = FocusNode();

  @override
  void dispose() {
    _noteTitleController.dispose();
    _disTitleController.dispose();
    titleFocusNode.dispose();
    disFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: darkMode
              ? ColorPalate.black2
              : ColorPalate.DARK_PRIMERY.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.paddingSizeExtraLarge),
            Container(
              width: double.infinity,
              child: Text('New Sticky Notes',
                  textAlign: TextAlign.center, style: titleHeader),
            ),
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
                    focusNode: titleFocusNode,
                    radius: 8.0,
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault),
                  TextInputField(
                    controller: _disTitleController,
                    hintText: 'Enter your notes',
                    inputType: TextInputType.multiline,
                    label: 'Notes',
                    radius: 8.0,
                    focusNode: disFocusNode,
                    maxLines: 6,
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault),
                  CustomButton(
                    onPressed: () {
                      print('1');
                      if (_noteTitleController.text.isEmpty) {
                        showSnackBar(
                            message: 'Field is required',
                            isError: true,
                            isToaster: true);
                      } else if (_disTitleController.text.isEmpty) {
                        showSnackBar(
                            message: 'Field is required',
                            isError: true,
                            isToaster: true);
                      } else {
                        final currentDate = DateFormat('d/M/y')
                            .format(DateTime.now())
                            .toString();
                        ref.read(notesProvider).addNewNote(NoteModel(
                            titleTask: _noteTitleController.text.trim(),
                            createdNoteDate: currentDate,
                            disCription: _disTitleController.text.trim()));
                        Get.back();
                        showSnackBar(
                            message: 'Task Create Successfully!',
                            isError: false,
                            isToaster: true);
                      }
                    },
                    title: 'Create Note',
                    color: ColorPalate.ORANGE,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
