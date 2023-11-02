// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taskplus/Custom/Widget/ShowCustomSnackbar.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Images/Image_plate.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class CardTodoWidget extends ConsumerWidget {
  final String titleTask;
  final String disCription;
  final int getIndex;
  final bool isDone;
  final String docID;
  final String dateTask;
  final String? repeatTask;
  final String startTimeTask;
  final String endTimeTask;
  final String? rimenderTask;
  final String cateogry;
  CardTodoWidget(
      {required this.getIndex,
      required this.titleTask,
      required this.disCription,
      required this.isDone,
      required this.docID,
      required this.dateTask,
      this.repeatTask,
      required this.startTimeTask,
      required this.endTimeTask,
      this.rimenderTask,
      required this.cateogry,
      super.key});

  String formatDate(String dateStr) {
    DateFormat inputFormat = DateFormat('d/M/y');
    DateTime date = inputFormat.parse(dateStr);
    DateTime currentDate = DateTime.now();

    if (date.year == currentDate.year &&
        date.month == currentDate.month &&
        date.day == currentDate.day) {
      return 'Today';
    } else if (date.year == currentDate.year &&
        date.month == currentDate.month &&
        date.day == currentDate.day - 1) {
      return 'Yesterday';
    } else if (date.year == currentDate.year &&
        date.month == currentDate.month &&
        date.day == currentDate.day + 1) {
      return 'Tomorrow';
    } else {
      DateFormat formatter = DateFormat('d/M/y');
      return formatter.format(date);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchData);
    final darkMode = ref.watch(darkModeProvider);
    return todoData.when(
            data: (todoData) {
              Color CategryColor = ColorPalate.DARK_PRIMERY;
              final getCateogry = cateogry;
              // todoData[getIndex].cateogry;
              String displayText = '';
              switch (getCateogry) {
                case 'Learning':
                  CategryColor = ColorPalate.ORANGE;
                  displayText = 'Learn';
                  break;
                case 'Working':
                  CategryColor = ColorPalate.DarkBULE;
                  displayText = 'Work';
                  break;
                case 'Shoping':
                  CategryColor = ColorPalate.Pink;
                  displayText = 'Shop';
                  break;
                case 'Private':
                  CategryColor = ColorPalate.BLUE;
                  displayText = 'Private';
                  break;
                case 'Health':
                  CategryColor = ColorPalate.GREEN;
                  displayText = 'Health';
                  break;
                case 'Genral':
                  CategryColor = ColorPalate.Yellow;
                  displayText = 'Genral';
                  break;
              }
              return Stack(
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: darkMode ? ColorPalate.BLACK : ColorPalate.WHITE,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: CategryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12))),
                          width: 20,
                          // child: Text('data'),
                          //aditya
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: displayText
                                .toUpperCase()
                                .split('')
                                .map((letter) {
                              return Text(
                                letter,
                                style: TextStyle(
                                    color: ColorPalate.WHITE,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              );
                            }).toList(),
                          ),
                        ),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  titleTask,
                                  // todoData[getIndex].titleTask,
                                  style: titleRegular,
                                ),
                                subtitle: Container(
                                  width: 150,
                                  child: Text(
                                    disCription,
                                    // todoData[getIndex].disCription,
                                    maxLines: 2,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                    style: titilliumRegular.copyWith(
                                        color: ColorPalate.GREY),
                                  ),
                                ),
                                trailing: Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                      shape: CircleBorder(),
                                      activeColor: CategryColor,
                                      value: isDone,
                                      // todoData[getIndex].isDone,
                                      onChanged: (value) {
                                        ref.read(servicesProvider).updateTask(
                                            // todoData[getIndex].docID
                                            docID,
                                            value);
                                        if (value == true) {
                                          showSnackBar(
                                              message: 'Task Completed',
                                              isToaster: true);
                                        } else {
                                          showSnackBar(
                                              message: 'Task Pending',
                                              isToaster: true);
                                        }
                                      }),
                                ),
                              ),
                              Divider(
                                thickness: 1.5,
                                color: ColorPalate.GREY.withOpacity(0.2),
                              ),
                              Row(
                                children: [
                                  // Text(todoData[getIndex].dateTask),
                                  Text(
                                    formatDate(dateTask
                                        // todoData[getIndex].dateTask
                                        ),
                                    style: titilliumRegular.copyWith(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.circle,
                                    size: 8,
                                  ),
                                  SizedBox(width: 5),
                                  Text(startTimeTask,
                                      // todoData[getIndex].startTimeTask,
                                      style: titilliumRegular.copyWith(
                                          fontWeight: FontWeight.w500)),
                                  endTimeTask == 'HH : MM'
                                      ? Text('')
                                      : Text(
                                          // '-${todoData[getIndex].endTimeTask}',
                                          '-${endTimeTask}',
                                          style: titilliumRegular.copyWith(
                                              fontWeight: FontWeight.w500),
                                        ),

                                  SizedBox(width: 5),
                                  // todoData[getIndex].repeatTask
                                  repeatTask == 'select'
                                      ? Text('')
                                      : InkWell(
                                          onTap: () {
                                            showSnackBar(
                                                message: 'Repation Active',
                                                isError: false,
                                                isToaster: true);
                                          },
                                          child: Icon(
                                            Icons.notifications_active,
                                            size: 15,
                                          ),
                                        ),
                                ],
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                  isDone
                      ? Positioned(
                          bottom: 5,
                          right: 60,
                          child: Image.asset(
                            ImagesProvider.COMPLETED,
                            height: 40,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : SizedBox()
                ],
              );
            },
            error: (error, StackTrace) => Center(child: Text('Error')),
            loading: () => Center(
                  child: CircularProgressIndicator(),
                )) ??
        SizedBox();
  }
}
