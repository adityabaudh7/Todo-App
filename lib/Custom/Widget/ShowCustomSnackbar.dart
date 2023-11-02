import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';

void showSnackBar(
    {required String message, bool? isError, bool isToaster = false}) {
  if (isToaster) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isError == true
            ? Colors.red.withOpacity(0.8)
            : isError == false
                ? Colors.green.withOpacity(0.8)
                : ColorPalate.BLACK,
        textColor: Colors.white,
        fontSize: 12.0);
  } else {
    Get.snackbar(
      isError == true ? 'Error' : 'Success',
      '',
      messageText: Text(
        message,
        style: titleRegular,
      ),
      snackPosition: SnackPosition.TOP,
      barBlur: 50.0,
      overlayBlur: 0.5,
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: isError == true
          ? Colors.red.withOpacity(0.5)
          : Colors.green.withOpacity(0.5),
    );
  }
}
