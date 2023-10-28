// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taskplus/Custom/Widget/ShowCustomSnackbar.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Dimensions.dart';
import 'package:taskplus/Theme/text_theme.dart';
import 'package:taskplus/features/Task/Controller/Todo_Controller.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';
import 'package:taskplus/features/Task/Widget/Shimer_card.dart';
import 'package:taskplus/features/Task/Widget/Todo_Card_widget.dart';

class AllTaskScreen extends ConsumerWidget {
  const AllTaskScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoDataList = ref.watch(fetchData);
    final darkMode = ref.watch(darkModeProvider);
    return Scaffold(
        backgroundColor:
            darkMode ? ColorPalate.black2 : ColorPalate.LITE_PRIMERY,
        appBar: AppBar(
          backgroundColor: darkMode ? ColorPalate.BLACK : ColorPalate.WHITE,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                FontAwesomeIcons.arrowLeft,
              )),
          title: Text(
            'All Todo Task',
            style: titleHeader,
          ),
        ),
        body: todoDataList.value == null
            ? SimmerScreen()
            : ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: todoDataList.value!.length,
                itemBuilder: (context, index) {
                  final TodoTask = todoDataList.value![index];
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
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Delete"),
                                    onPressed: () {
                                      final todoData = ref.watch(fetchData);
                                      final docID =
                                          todoData.value![index].docID;
                                      TodoController().deleteTask(docID);
                                      Navigator.of(context)
                                          .pop(); // Close the dialog
                                      showSnackBar(
                                          message: 'Task Deleted',
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
                      padding: EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeExtraSmall,
                          horizontal: Dimensions.paddingSizeSmall),
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
              ));
  }
}
