// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskplus/Custom/Widget/Custom_Button.dart';
import 'package:taskplus/Custom/Widget/ShowCustomSnackbar.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/Dimensions.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Notes/Model/S_Notes_Model.dart';
import 'package:taskplus/features/Notes/Provider/Note_Repo_Provider.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class AddNoteScreen extends ConsumerStatefulWidget {
  final String noteTitle;
  final String note;
  final String createdDate;
  final String? docID;
  AddNoteScreen(
      {Key? key,
      required this.note,
      required this.noteTitle,
      required this.createdDate,
      this.docID})
      : super(key: key);

  @override
  ConsumerState<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends ConsumerState<AddNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _disTitleController = TextEditingController();
  @override
  void dispose() {
    _noteTitleController.dispose();
    _disTitleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.noteTitle != null && widget.note != null) {
      _noteTitleController.text = widget.noteTitle;
      _disTitleController.text = widget.note;
    }
    super.initState();
  }

  void CreateOrUpdateNote() async {
    try {
      final currentDate = DateFormat('d/M/y').format(DateTime.now()).toString();
      if (widget.docID != null) {
        // for update user
        ref.read(notesProvider).updateTask(
              widget.docID,
              _noteTitleController.text.trim(),
              _disTitleController.text.trim(),
            );
        Get.back();
        showSnackBar(
          message: 'Note Updated Successfully!',
          isError: false,
          isToaster: true,
        );
      } else {
        // Create a new note
        if (_noteTitleController.text.isEmpty) {
          showSnackBar(
            message: 'Title is required',
            isError: true,
            isToaster: true,
          );
        } else if (_disTitleController.text.isEmpty) {
          showSnackBar(
            message: 'Note is required',
            isError: true,
            isToaster: true,
          );
        } else {
          // Create a new note
          ref.read(notesProvider).addNewNote(NoteModel(
                titleTask: _noteTitleController.text.trim(),
                createdNoteDate: currentDate,
                disCription: _disTitleController.text.trim(),
              ));
          Get.back();
          showSnackBar(
            message: 'Note Created Successfully!',
            isError: false,
            isToaster: true,
          );
        }
      }
    } catch (e) {
      print("Aditya issue : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    return Scaffold(
        backgroundColor: darkMode ? ColorPalate.black1 : ColorPalate.WHITE,
        appBar: AppBar(
          title: const Text('Add Note Screen', style: titleHeader),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: Dimensions.homePagePadding),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeThirtyFive),
                      child: TextFormField(
                        controller: _noteTitleController,
                        keyboardType: TextInputType.name,
                        cursorColor: ColorPalate.DARK_PRIMERY,
                        decoration: const InputDecoration(
                            // border: InputBorder.none,
                            hintText: 'Title',
                            hintStyle: titleHeader),
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeThirtyFive),
                      child: TextFormField(
                        controller: _disTitleController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        cursorColor: ColorPalate.DARK_PRIMERY,
                        decoration: const InputDecoration(
                          hintText: 'Notes',
                          hintStyle: titleHeader,
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    CustomButton(
                      onPressed: () {
                        CreateOrUpdateNote();
                      },
                      title:
                          widget.docID != null ? 'Update Note' : 'Create Note',
                      color: ColorPalate.ORANGE,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
