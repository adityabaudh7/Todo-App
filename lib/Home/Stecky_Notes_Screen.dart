// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:taskplus/Theme/Animation/animation_plate.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/text_theme.dart';
import 'package:taskplus/features/Notes/Add_Note_Modal.dart';
import 'package:taskplus/features/Notes/Provider/Note_Repo_Provider.dart';
import 'package:taskplus/features/Notes/Widgets/Notes_Card_widget.dart';
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
    final noteData = ref.watch(fetchNoteData);
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
      body: noteData.value!.length != 0
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: noteData.value!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: NotesCardWidget(index: index),
                );
              },
            )
          : Center(
              child: Container(
                  height: 150.00,
                  width: double.infinity,
                  child: Lottie.asset(Motion.NODATA)),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            myBottamModal(context);
          });
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
