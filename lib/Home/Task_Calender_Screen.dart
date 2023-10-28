// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/text_theme.dart';
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
          title: Text(
            'Task Calender',
            style: titleHeader,
          ),
          // toolbarHeight: 0,
        ),
        body: ListView(
          children: [
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
                      color: ColorPalate.BLACK,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: ColorPalate.BLACK,
                  ),
                  rightChevronIcon: Icon(
                    FontAwesomeIcons.arrowRight,
                    color: ColorPalate.BLACK,
                  )),
              formatAnimationCurve: Curves.bounceIn,
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                      color: ColorPalate.RED, fontWeight: FontWeight.w600),
                  weekdayStyle: TextStyle(
                      color: ColorPalate.BLACK, fontWeight: FontWeight.w600)),
              calendarStyle: CalendarStyle(
                  weekendTextStyle: TextStyle(color: ColorPalate.RED),
                  markersMaxCount: 3,
                  markerDecoration: BoxDecoration(
                      color: ColorPalate.black1, shape: BoxShape.circle),
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
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: todoData.value?.length ?? 0,
                itemBuilder: (context, index) {
                  final selectedDate =
                      DateFormat('d/M/y').format(_selectedDay!);
                  final task = todoData.value?[index];
                  if (task != null && task.dateTask == selectedDate) {
                    final color = listColor[index % listColor.length];
                    return Container(
                      decoration: BoxDecoration(
                          color: color.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(1, 2),
                                color: ColorPalate.GREY.withOpacity(0.6),
                                blurRadius: 6.0,
                                spreadRadius: 1.0,
                                blurStyle: BlurStyle.normal)
                          ]),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.solidHandPointUp,
                          color: ColorPalate.WHITE,
                        ),
                        title: Text(
                          task.titleTask,
                          style: titilliumRegular,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.startTimeTask,
                              style: titleRegular,
                            )
                          ],
                        ),
                        // Add other task details as needed
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ),
          ],
        ));
  }
}
