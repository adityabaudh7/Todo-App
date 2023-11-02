// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/Dimensions.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Notes/Provider/Note_Repo_Provider.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class NotesCardWidget extends ConsumerWidget {
  final String Title;
  final String Notes;
  final String createdDate;
  final int index;
  const NotesCardWidget(
      {Key? key,
      required this.Notes,
      required this.Title,
      required this.index,
      required this.createdDate})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    // final noteData = ref.watch(fetchNoteData);
    return Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: darkMode
                    ? Colors.grey.withOpacity(0.3)
                    : ColorPalate.GREY.withOpacity(0.8),
                spreadRadius: 1,
                blurRadius: darkMode ? 10 : 5,
                offset: const Offset(2, 4),
              )
            ],
            borderRadius: BorderRadius.circular(20),
            color: darkMode ? ColorPalate.BLACK : ColorPalate.WHITE),
        child: Column(
          children: [
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ColorPalate.PRIMERY1.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        color: ColorPalate.DARK_PRIMERY2,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                        )),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: titleHeaderLarge.copyWith(
                            fontSize: 20, color: ColorPalate.WHITE),
                      ),
                    ),
                  ),
                  const SizedBox(width: 80),
                  const Text(
                    'Sticky Note',
                    style: titleHeader,
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                // noteData.value![index].titleTask,
                Title,
                style: titleHeader.copyWith(
                    fontWeight: FontWeight.w500, fontSize: 16),
              ),
              subtitle: Text(
                Notes,
                // noteData.value![index].disCription,
                style: titilliumRegular,
                textAlign: TextAlign.justify,
              ),
            ),
            // Container(
            //     height: 15,
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         color: ColorPalate.Yellow.withOpacity(0.8),
            //         borderRadius: const BorderRadius.only(
            //             bottomLeft: Radius.circular(18),
            //             bottomRight: Radius.circular(18))))
          ],
        ));
  }
}
