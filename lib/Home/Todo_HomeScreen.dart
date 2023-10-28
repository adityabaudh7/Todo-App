// ignore_for_file: prefer_const_constructors, deprecated_member_use, sort_child_properties_last, unnecessary_null_comparison, unnecessary_brace_in_string_interps, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taskplus/Custom/Widget/ShowCustomSnackbar.dart';
import 'package:taskplus/Screens/Todo_notification.dart';
import 'package:taskplus/Settings/services/Greet_Services.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Dimensions.dart';
import 'package:taskplus/Theme/text_theme.dart';
import 'package:taskplus/features/Post/Widget/Slider_Screen_View.dart';
import 'package:taskplus/features/Task/All_Task_Screen.dart';
import 'package:taskplus/features/Task/Controller/Todo_Controller.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';
import 'package:taskplus/features/Task/Widget/Shimer_card.dart';
import 'package:taskplus/features/Task/Widget/Todo_Card_widget.dart';
import 'package:taskplus/features/Task/add_task_Screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(getUserData);
    final greeting = ref.watch(greetingProvider);
    final todoDataList = ref.watch(fetchData);
    final darkMode = ref.watch(darkModeProvider);
    return Scaffold(
        backgroundColor: darkMode
            ? ColorPalate.black2
            : ColorPalate.DARK_PRIMERY.withOpacity(0.1),
        appBar: AppBar(
          backgroundColor:
              darkMode ? ColorPalate.BLACK : ColorPalate.DARK_PRIMERY,
          centerTitle: true,
          leading: userData.value == null
              ? Container(
                  margin: EdgeInsets.only(left: 15),
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPalate.YELLOWTODO,
                  ),
                  child: Icon(
                    Icons.person,
                    color: ColorPalate.WHITE,
                  ),
                )
              : InkWell(
                  onTap: () {
                    // Get.to(ProfileScreen(), transition: Transition.leftToRight);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 15),
                    height: 44,
                    width: 44,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      // color: MyappTheme.greycard,
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(3.7),
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(userData.value!.profilePic),
                              fit: BoxFit.cover),
                          border:
                              Border.all(width: 3, color: ColorPalate.WHITE),
                          shape: BoxShape.circle,
                          color: ColorPalate.GREY.withOpacity(0.1)),
                    ),
                  ),
                ),
          title: Text('To-do-List',
              style: titleHeader.copyWith(color: ColorPalate.WHITE)),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(TodoNotificationScreen(),
                      transition: Transition.fadeIn);
                },
                icon: Icon(
                  FontAwesomeIcons.solidBell,
                  color: ColorPalate.WHITE,
                  size: 20,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall,
                vertical: Dimensions.paddingSizeLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: Dimensions.topSpace),
                // AnimatedTextKit(
                //   animatedTexts: [
                //     TyperAnimatedText(
                // '${greeting}',
                // textStyle:
                //     titilliumRegular.copyWith(color: ColorPalate.BLACK),
                //     )
                //   ],
                //   repeatForever: true,
                // ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${greeting}, ',
                        style: titleHeader.copyWith(
                            fontFamily: 'shipro',
                            // color: ColorPalate.BLACK,
                            fontSize: 16)),
                    userData.value == null
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 25,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          )
                        : Text(
                            userData.value!.name.toString(),
                            style: titleHeader.copyWith(
                                fontFamily: 'shipro',
                                // color: ColorPalate.BLACK,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                    Text(
                      'We are glad to see you back',
                      style: titleRegular,
                    )
                  ],
                ),

                SizedBox(height: Dimensions.paddingSizeExtraLarge),
                TodoSliderScreenView(),
                SizedBox(height: Dimensions.paddingSizeExtraLarge),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.to(AllTaskScreen());
                            },
                            child: Text('Upcoming Task', style: titleHeader)),
                        Row(
                          children: [
                            Text('Today',
                                style: titleRegular.copyWith(
                                    fontSize: 10, fontWeight: FontWeight.w600)),
                            Text(' | ',
                                style: titleHeader.copyWith(
                                    fontSize: 10,
                                    color: ColorPalate.GREY,
                                    fontWeight: FontWeight.w600)),
                            Text(
                              DateFormat('d MMM yyyy').format(DateTime.now()),
                              style: titleRegular.copyWith(
                                  fontSize: 10,
                                  color: ColorPalate.GREY,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(AddTaskScreen(), transition: Transition.zoom);
                      },
                      child: Text('Add Task',
                          style: titleHeader.copyWith(
                              color: ColorPalate.DARK_PRIMERY, fontSize: 12)),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(100, 20)),
                          side: MaterialStateProperty.all(
                            BorderSide(
                              color: ColorPalate.DARK_PRIMERY,
                              width: 1.2,
                            ),
                          )),
                    )
                  ],
                ),
                SizedBox(height: Dimensions.paddingSizeExtraLarge),
                todoDataList.value == null
                    ? SimmerScreen()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: todoDataList.value == null
                            ? 0
                            : todoDataList.value!.where((task) {
                                final dateFormat = DateFormat('d/M/y');
                                final taskDate =
                                    dateFormat.parse(task.dateTask);
                                final now = DateTime.now();
                                final currentDate =
                                    DateTime(now.year, now.month, now.day);
                                print(
                                    "Current Date: ${currentDate}+ $taskDate ");
                                return taskDate.isAtSameMomentAs(currentDate);
                              }).length,
                        itemBuilder: (context, index) {
                          final filteredTasks =
                              todoDataList.value!.where((task) {
                            final dateFormat = DateFormat('dd/MM/yyyy');
                            final taskDate = dateFormat.parse(task.dateTask);
                            final now = DateTime.now();
                            final currentDate =
                                DateTime(now.year, now.month, now.day);
                            return taskDate.isAtSameMomentAs(currentDate);
                          }).toList();
                          final TodoTask = filteredTasks[index];
                          return Slidable(
                            key: ValueKey(0),
                            endActionPane:
                                ActionPane(motion: ScrollMotion(), children: [
                              SlidableAction(
                                flex: 2,
                                onPressed: (context) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Confirm Delete"),
                                        content: Text(
                                            "Are you sure you want to delete this item?"),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Delete"),
                                            onPressed: () {
                                              final docID = TodoTask.docID;
                                              TodoController()
                                                  .deleteTask(docID);
                                              Navigator.of(context).pop();
                                              showSnackBar(
                                                  message: 'Deleted Task',
                                                  isError: false,
                                                  isToaster: true);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                backgroundColor: darkMode
                                    ? ColorPalate.black2
                                    : ColorPalate.TRANSPARENT,
                                foregroundColor: ColorPalate.RED,
                                icon: FontAwesomeIcons.solidTrashCan,
                                label: 'Delete',
                              ),
                            ]),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: CardTodoWidget(
                                getIndex: index,
                                titleTask: TodoTask.titleTask,
                                disCription: TodoTask.disCription,
                                isDone: TodoTask.isDone,
                                docID: TodoTask.docID ?? '',
                                dateTask: TodoTask.dateTask,
                                startTimeTask: TodoTask.startTimeTask,
                                endTimeTask: TodoTask.endTimeTask,
                                repeatTask: TodoTask.repeatTask,
                                cateogry: TodoTask.cateogry,
                              ),
                            ),
                          );
                        },
                      )
              ],
            ),
          ),
        ));
  }
}
