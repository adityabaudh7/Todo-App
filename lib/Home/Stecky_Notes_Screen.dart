// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/text_theme.dart';
import 'package:taskplus/features/Notes/Add_Note_Modal.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StickyNotesScreen extends ConsumerStatefulWidget {
  const StickyNotesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<StickyNotesScreen> createState() => _StickyNotesScreenState();
}

class _StickyNotesScreenState extends ConsumerState<StickyNotesScreen> {
  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    return Scaffold(
      backgroundColor: darkMode
          ? ColorPalate.black2
          : ColorPalate.DARK_PRIMERY.withOpacity(0.1),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Short Notes',
          style: titleHeader,
        ),
      ),
      body: ListView(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          myBottamModal(context);
       
        },
        child: Icon(
          FontAwesomeIcons.plus,
          color: ColorPalate.WHITE,
        ),
        elevation: 5.0,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}

void myBottamModal(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddNoteModal();
      });
}
