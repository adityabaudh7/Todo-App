// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskplus/Settings/services/Greet_Services.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';

class DropdownWidget extends ConsumerStatefulWidget {
  final String titleText;
  final bool isOptional;
  final List<String> items;
  final String dropdownvalue;
  final bool isRepeat;
  final String hint;

  DropdownWidget({
    Key? key,
    required this.titleText,
    required this.items,
    required this.dropdownvalue,
    this.isOptional = false,
    required this.isRepeat,
    required this.hint,
  }) : super(key: key);

  @override
  ConsumerState<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends ConsumerState<DropdownWidget> {
  late String dropdownvalue;

  @override
  void initState() {
    super.initState();
    dropdownvalue = widget.dropdownvalue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.titleText,
              style: titleRegular,
            ),
            widget.isOptional
                ? Text(
                    ' (Optional)',
                    style: titilliumRegular.copyWith(color: ColorPalate.RED),
                  )
                : Text('')
          ],
        ),
        SizedBox(height: 5.0),
        Container(
          width: 143,
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          decoration: BoxDecoration(
              border: Border.all(width: 0.8, color: ColorPalate.DARK_PRIMERY),
              color: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8)),
          child: DropdownButton(
            borderRadius: BorderRadius.circular(8),
            // isExpanded: true,
            hint: Text(
              'Select an option',
              style: titilliumRegular.copyWith(color: ColorPalate.GREY),
            ),
            value: dropdownvalue,
            isDense: true,
            underline: SizedBox(height: 0),
            icon: Icon(
              FontAwesomeIcons.angleDown,
              size: 20,
              color: ColorPalate.DARK_PRIMERY.withOpacity(0.5),
            ),
            items: widget.items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
                if (widget.isRepeat == true) {
                  ref.read(selectedRepeatProvider.notifier).state = newValue;
                } else {
                  ref.read(selectedReminderProvider.notifier).state = newValue;
                }
              });
            },
            // onChanged: (String? newValue) {
            //   setState(() {
            //     dropdownvalue = newValue!;
            //   });
            // },
          ),
        ),
      ],
    );
  }
}
