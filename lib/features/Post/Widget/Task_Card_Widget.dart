import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/Dimensions.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class TaskCardWidget extends ConsumerWidget {
  const TaskCardWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    final isPending = ref.watch(pendingTasksProvider);
    final total = ref.watch(fetchData);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: darkMode ? ColorPalate.BLACK : ColorPalate.WHITE,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.fontSizeExtraSmall),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('MMMM, EEEE, dd').format(DateTime.now()),
                  style: titleRegular.copyWith(
                      fontSize: 12,
                      color: ColorPalate.GREY,
                      fontWeight: FontWeight.w500),
                ),
                total.value != null || isPending.value != null
                    ? Text(
                        '${isPending.value!.length}/${total.value!.length} Tasks',
                        style: titleHeader,
                      )
                    : Text('3/10')
              ],
            ),
            Spacer(),
            Image.network(
              'https://firebasestorage.googleapis.com/v0/b/todo-plus-c097a.appspot.com/o/firebase-wali.png?alt=media&token=ca0a67bd-5be6-457f-b7bf-68f02e832aff&_gl=1*8ui0d0*_ga*MjA0MjgwMDg2Ny4xNjg5NzMzNzcy*_ga_CW55HF8NVT*MTY5ODkyMDgwNC4xMDcuMS4xNjk4OTIyODI4LjQxLjAuMA..',
            )
          ],
        ),
      ),
    );
  }
}
