// ignore_for_file: prefer_const_constructors

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/Dimensions.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Task/All_Task_Screen.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class TaskCalenderScreen extends ConsumerStatefulWidget {
  const TaskCalenderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TaskCalenderScreen> createState() => _TaskCalenderScreenState();
}

class _TaskCalenderScreenState extends ConsumerState<TaskCalenderScreen> {
  CalendarFormat _calenderFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<Color> listColor = [
    Color.fromARGB(255, 114, 165, 233),
    Color(0xff98c1d9),
    Color.fromARGB(255, 55, 133, 133),
    Color.fromARGB(255, 240, 129, 101),
  ];
  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
    final todoData = ref.watch(fetchData);
    return Scaffold(
        backgroundColor: darkMode
            ? ColorPalate.black2
            : ColorPalate.DARK_PRIMERY.withOpacity(0.1),
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.calendar),
              SizedBox(width: 10),
              Text(
                'Task Calender',
                style: titleHeader,
              ),
            ],
          ),
          // toolbarHeight: 0,
        ),
        body: ListView(
          children: [
            SizedBox(height: 3),
            DottedLine(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              lineLength: double.infinity,
              lineThickness: 1.0,
              dashLength: 4.0,
              dashColor: darkMode ? ColorPalate.GREY : Colors.black,
              // dashGradient: [Colors.red, Colors.blue],
              dashRadius: 0.0,
              dashGapLength: 4.0,
              dashGapColor: Colors.transparent,
              // dashGapGradient: [Colors.red, Colors.blue],
              dashGapRadius: 0.0,
            ),
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: DateTime(2022),
              lastDay: DateTime(2030),
              calendarFormat: _calenderFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              rowHeight: 60,
              daysOfWeekHeight: 50,
              headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                      color: darkMode ? ColorPalate.WHITE : ColorPalate.BLACK,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  titleCentered: true,
                  formatButtonVisible: true,
                  formatButtonPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  formatButtonDecoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color:
                              darkMode ? ColorPalate.WHITE : ColorPalate.BLACK),
                      borderRadius: BorderRadius.circular(20)),
                  formatButtonTextStyle: titleRegular,
                  leftChevronIcon: Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: darkMode ? ColorPalate.WHITE : ColorPalate.BLACK,
                  ),
                  rightChevronIcon: Icon(
                    FontAwesomeIcons.arrowRight,
                    color: darkMode ? ColorPalate.WHITE : ColorPalate.BLACK,
                  )),
              formatAnimationCurve: Curves.bounceIn,
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                      color: ColorPalate.RED, fontWeight: FontWeight.w600),
                  weekdayStyle: TextStyle(
                      color: darkMode ? ColorPalate.WHITE : ColorPalate.BLACK,
                      fontWeight: FontWeight.w600)),
              calendarStyle: CalendarStyle(
                  weekendTextStyle: TextStyle(color: ColorPalate.RED),
                  markersMaxCount: 3,
                  markerDecoration: BoxDecoration(
                      color: darkMode ? ColorPalate.WHITE : ColorPalate.black1,
                      shape: BoxShape.circle),
                  isTodayHighlighted: true,
                  todayTextStyle: TextStyle(
                      color: ColorPalate.WHITE,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  todayDecoration: BoxDecoration(
                      color: ColorPalate.DARK_PRIMERY.withOpacity(0.9),
                      shape: BoxShape.circle),
                  selectedTextStyle: TextStyle(
                      color: ColorPalate.WHITE,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  selectedDecoration: BoxDecoration(
                      color: ColorPalate.ORANGE, shape: BoxShape.circle)),
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              // for selecte day
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              // for change calender formate
              onFormatChanged: (formate) {
                if (_calenderFormat != formate) {
                  setState(() {
                    _calenderFormat = formate;
                  });
                }
              },
              eventLoader: (day) {
                final selectedDate = DateFormat('d/M/y').format(day);
                final eventData = ref.watch(fetchData);

                return eventData.when(
                  data: (tasks) {
                    print('selctecdData?????????????????????${selectedDate}');
                    final events = tasks
                        .where((task) => task.dateTask == selectedDate)
                        .toList();
                    return events;
                  },
                  error: (_, __) => ['Errror ........................'],
                  loading: () => ['Lodding ..........................'],
                );
              },
            ),

            Expanded(
                child: Container(
              // height: 140,
              child: ListView.builder(
                  itemCount: todoData.value?.length ?? 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final selectedDate =
                        DateFormat('d/M/y').format(_selectedDay!);
                    final task = todoData.value?[index];
                    if (task != null && task.dateTask == selectedDate) {
                      final color = listColor[index % listColor.length];

                      return GestureDetector(
                        onTap: () {
                          Get.to(AllTaskScreen(), transition: Transition.fade);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: 300,
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
                              color: darkMode
                                  ? ColorPalate.BLACK
                                  : ColorPalate.WHITE),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: color.withOpacity(0.8),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.folderOpen,
                                      color: ColorPalate.WHITE,
                                      size: Dimensions.fontSizeLarge,
                                    ),
                                    Text(
                                      "Todo",
                                      style: titleRegular.copyWith(
                                          color: ColorPalate.WHITE),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 3),
                              DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                lineLength: double.infinity,
                                lineThickness: 1.0,
                                dashLength: 4.0,
                                dashColor:
                                    darkMode ? ColorPalate.GREY : Colors.black,
                                // dashGradient: [Colors.red, Colors.blue],
                                dashRadius: 0.0,
                                dashGapLength: 4.0,
                                dashGapColor: Colors.transparent,
                                // dashGapGradient: [Colors.red, Colors.blue],
                                dashGapRadius: 0.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12)
                                    .copyWith(bottom: 0),
                                child: Text(
                                  task.cateogry,
                                  style: titleHeader,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12)
                                        .copyWith(bottom: 5),
                                child: Text(
                                  task.titleTask,
                                  style: titleRegular,
                                ),
                              ),
                              DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                lineLength: double.infinity,
                                lineThickness: 1.0,
                                dashLength: 4.0,
                                dashColor:
                                    darkMode ? ColorPalate.GREY : Colors.black,
                                // dashGradient: [Colors.red, Colors.blue],
                                dashRadius: 0.0,
                                dashGapLength: 4.0,
                                dashGapColor: Colors.transparent,
                                // dashGapGradient: [Colors.red, Colors.blue],
                                dashGapRadius: 0.0,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12)
                                        .copyWith(top: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      task.startTimeTask,
                                      style: titilliumRegular.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    task.endTimeTask != "HH : MM"
                                        ? Text(
                                            '-${task.endTimeTask}',
                                            style: titilliumRegular.copyWith(
                                                fontWeight: FontWeight.w500),
                                          )
                                        : Text(''),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
            )),
            // Expanded(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     physics: NeverScrollableScrollPhysics(),
            //     itemCount: todoData.value?.length ?? 0,
            //     itemBuilder: (context, index) {
            //       final selectedDate =
            //           DateFormat('d/M/y').format(_selectedDay!);
            //       final task = todoData.value?[index];
            //       if (task != null && task.dateTask == selectedDate) {
            //         final color = listColor[index % listColor.length];
            //         return Container(
            //           decoration: BoxDecoration(
            //               color: color.withOpacity(0.9),
            //               borderRadius: BorderRadius.circular(8),
            //               boxShadow: [
            //                 BoxShadow(
            //                     offset: Offset(1, 2),
            //                     color: ColorPalate.GREY.withOpacity(0.6),
            //                     blurRadius: 6.0,
            //                     spreadRadius: 1.0,
            //                     blurStyle: BlurStyle.normal)
            //               ]),
            //           margin: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
            //           child: ListTile(
            //             leading: Icon(
            //               FontAwesomeIcons.solidHandPointUp,
            //               color: ColorPalate.WHITE,
            //             ),
            //             title: Text(
            //               task.titleTask,
            //               style: titilliumRegular,
            //             ),
            //             subtitle: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   task.startTimeTask,
            //                   style: titleRegular,
            //                 )
            //               ],
            //             ),
            //             // Add other task details as needed
            //           ),
            //         );
            //       } else {
            //         return SizedBox();
            //       }
            //     },
            //   ),
            // ),
          ],
        ));
  }
}
