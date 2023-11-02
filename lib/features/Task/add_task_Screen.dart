// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:taskplus/Custom/Todo_Input_Text_Screen.dart';
import 'package:taskplus/Custom/Widget/Custom_Button.dart';
import 'package:taskplus/Custom/Widget/ShowCustomSnackbar.dart';
import 'package:taskplus/features/Task/model/todo_model.dart';
import 'package:taskplus/Settings/services/Greet_Services.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/Dimensions.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Task/Provider/date_time_provider.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';
import 'package:taskplus/features/Task/Widget/Dropdown_widget.dart';
import 'package:taskplus/features/Task/Widget/Radio_widget.dart';
import 'package:taskplus/features/Task/Widget/Date_Time_widget.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController discController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    print('Select Your Time');
    final getTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (getTime != null) {
      if (isStartTime) {
        ref.read(startTimeProvider.notifier).state = getTime.format(context);
        print("Start Time::${ref.read(startTimeProvider.notifier).state}");
      } else {
        ref.read(endTimeProvider.notifier).state = getTime.format(context);
        print("End Time::${ref.read(endTimeProvider.notifier).state}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final pickedDate = ref.watch(dateProvider);
    final startPickedTime = ref.watch(startTimeProvider);
    final endPickedTime = ref.watch(endTimeProvider);
    final getRadioValue = ref.watch(radioProvider);
    final selectedReminder = ref.watch(selectedReminderProvider);
    final selectedRepeatTask = ref.watch(selectedRepeatProvider);
    final darkMode = ref.watch(darkModeProvider);

    return Scaffold(
        backgroundColor: darkMode ? ColorPalate.black2 : ColorPalate.WHITE,
        appBar: AppBar(
          backgroundColor: darkMode ? ColorPalate.BLACK : ColorPalate.WHITE,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                FontAwesomeIcons.arrowLeft,
                // color: ColorPalate.BLACK,
              )),
          title: Text(
            'Add New Task To-do',
            style: titleHeader,
          ),
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Positioned(
                  bottom: -50,
                  right: -80,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
                        shape: BoxShape.circle),
                    height: 200,
                    width: 200,
                  )),
              Positioned(
                  bottom: -80,
                  right: 50,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
                        shape: BoxShape.circle),
                    height: 160,
                    width: 160,
                  )),
              ListView(
                physics: BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.normal),
                children: [
                  SizedBox(height: Dimensions.homePagePadding),
                  TextInputField(
                    controller: taskController,
                    hintText: 'Enter your new task',
                    inputType: TextInputType.text,
                    label: 'Task',
                    radius: 8.0,
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault),
                  TextInputField(
                    controller: discController,
                    hintText: 'Enter task discription',
                    inputType: TextInputType.multiline,
                    label: 'Discription',
                    radius: 8.0,
                    maxLines: 4,
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeThirtyFive),
                    child: Text('Category', style: titleRegular),
                  ),
                  // for category
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeLarge),
                    child: GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 2.5,
                      shrinkWrap: true,
                      children: [
                        RadioWidget(
                          categoryColor: ColorPalate.ORANGE,
                          titleRadio: 'Learn',
                          valueInput: 1,
                          onChangeValue: () {
                            final myValue = ref
                                .read(radioProvider.notifier)
                                .update((state) => 1);
                            print('MyValue :$myValue');
                          },
                        ),
                        RadioWidget(
                          categoryColor: ColorPalate.DarkBULE,
                          titleRadio: 'Work',
                          valueInput: 2,
                          onChangeValue: () {
                            final myvalue = ref
                                .read(radioProvider.notifier)
                                .update((state) => 2);
                            print('Value :  $myvalue');
                          },
                        ),
                        RadioWidget(
                          categoryColor: ColorPalate.Pink,
                          titleRadio: 'Shop',
                          valueInput: 3,
                          onChangeValue: () {
                            final myValue = ref
                                .read(radioProvider.notifier)
                                .update((state) => 3);
                            print('MyValue : $myValue');
                          },
                        ),
                        RadioWidget(
                          categoryColor: ColorPalate.BLUE,
                          titleRadio: 'Private',
                          valueInput: 4,
                          onChangeValue: () {
                            final myValue = ref
                                .read(radioProvider.notifier)
                                .update((state) => 4);
                            print('MyValue :$myValue');
                          },
                        ),
                        RadioWidget(
                          categoryColor: ColorPalate.GREEN,
                          titleRadio: 'Health',
                          valueInput: 5,
                          onChangeValue: () {
                            final myvalue = ref
                                .read(radioProvider.notifier)
                                .update((state) => 5);
                            print('Value :  $myvalue');
                          },
                        ),
                        RadioWidget(
                          categoryColor: ColorPalate.Yellow,
                          titleRadio: 'General',
                          valueInput: 6,
                          onChangeValue: () {
                            final myValue = ref
                                .read(radioProvider.notifier)
                                .update((state) => 6);
                            print('MyValue : $myValue');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeThirtyFive),
                    child: DateTimeWidget(
                      icon: FontAwesomeIcons.calendarDays,
                      isSelected: () async {
                        print('1');
                        DateTime currentDate = DateTime.now();
                        final getValue = await showDatePicker(
                          context: context,
                          initialDate: currentDate,
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2025),
                        );

                        if (getValue != null) {
                          final format = DateFormat('d/M/y');

                          final getDate = ref
                              .read(dateProvider.notifier)
                              .update((state) => format.format(getValue));
                          print(getDate);
                        }
                      },
                      titleText: 'Date',
                      valueText: pickedDate.toString(),
                    ),
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeThirtyFive),
                    child: Row(
                      children: [
                        DateTimeWidget(
                          icon: FontAwesomeIcons.clock,
                          isSelected: () {
                            selectTime(context, true);
                          },
                          titleText: 'Start Time',
                          valueText: startPickedTime.toString(),
                        ),
                        SizedBox(width: 5),
                        DateTimeWidget(
                          isOptional: true,
                          icon: FontAwesomeIcons.clock,
                          isSelected: () {
                            selectTime(context, false);
                          },
                          titleText: 'End Time',
                          valueText: endPickedTime.toString(),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.paddingSizeDefault),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeThirtyFive),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownWidget(
                          isOptional: true,
                          titleText: 'Remind',
                          items: [
                            'select option',
                            '5 min early',
                            '10 min early',
                            '30 min early',
                            '1 hour early'
                          ],
                          dropdownvalue: 'select option',
                          isRepeat: false,
                          hint: 'select',
                        ),
                        DropdownWidget(
                          isOptional: true,
                          titleText: 'Repeat',
                          items: [
                            'select option',
                            'Everyday',
                            'Weekly',
                            'Monthly',
                            'Yearly'
                          ],
                          dropdownvalue: 'select option',
                          isRepeat: true,
                          hint: 'Select',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Dimensions.paddingSizeLarge),
                  CustomButton(
                    color: ColorPalate.ORANGE,
                    onPressed: () {
                      if (taskController.text.isEmpty) {
                        showSnackBar(
                            message: 'Field is required',
                            isError: true,
                            isToaster: true);
                      } else if (discController.text.isEmpty) {
                        showSnackBar(
                            message: 'Field is required',
                            isError: true,
                            isToaster: true);
                      } else if (getRadioValue == 0) {
                        showSnackBar(
                            message: 'Category is required',
                            isError: true,
                            isToaster: true);
                      } else if (pickedDate == 'DD/MM/YYYY') {
                        showSnackBar(
                            message: 'Date is required',
                            isError: true,
                            isToaster: true);
                      } else if (startPickedTime == 'HH : MM') {
                        showSnackBar(
                            message: 'Start Time is required',
                            isError: true,
                            isToaster: true);
                      } else {
                        String _category = '';
                        switch (getRadioValue) {
                          case 1:
                            _category = 'Learning';
                          case 2:
                            _category = 'Working';
                          case 3:
                            _category = 'Shoping';
                          case 4:
                            _category = 'Private';
                          case 5:
                            _category = 'Health';
                          case 6:
                            _category = 'Genral';
                        }
                        print('i am aditya : ${startPickedTime}');
                        print("hhhhhhhhhhh : ${selectedReminder}");
                        print("ggggggggggg : ${selectedRepeatTask}");
                        ref.read(servicesProvider).addNewTask(TodoModel(
                            titleTask: taskController.text.trim(),
                            disCription: discController.text.trim(),
                            cateogry: _category.trim(),
                            dateTask: pickedDate.trim(),
                            startTimeTask: startPickedTime.trim(),
                            endTimeTask: endPickedTime.trim(),
                            repeatTask: selectedRepeatTask.trim(),
                            reminderTask: selectedReminder.trim(),
                            isDone: false));

                        showSnackBar(
                            message: 'Task Create Successfully!',
                            isError: false,
                            isToaster: true);
                        // Get.off(HomeScreen(), transition: Transition.zoom);
                        Get.back();
                      }
                    },
                    title: 'Create',
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
