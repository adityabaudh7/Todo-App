import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/Settings/services/Greet_Services.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class RadioWidget extends ConsumerWidget {
  final String titleRadio;
  final Color categoryColor;
  final int valueInput;
  final VoidCallback onChangeValue;
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.categoryColor,
    required this.valueInput,
    required this.onChangeValue,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioPro = ref.watch(radioProvider);
    final darkMode = ref.watch(darkModeProvider);
    return Material(
      color: darkMode ? ColorPalate.black2 : ColorPalate.WHITE,
      child: Theme(
        data: ThemeData(unselectedWidgetColor: categoryColor),
        child: RadioListTile(
            activeColor: categoryColor,
            contentPadding: EdgeInsets.zero,
            title: Transform.translate(
              offset: Offset(-22, 0),
              child: Text(
                titleRadio,
                style: TextStyle(
                    color: categoryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
            ),
            value: valueInput,
            groupValue: radioPro,
            onChanged: (value) {
              onChangeValue();
              print('Hello : $onChangeValue');
            }),
      ),
    );
  }
}
