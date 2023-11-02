// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskplus/Custom/Widget/ShowCustomSnackbar.dart';

Future<File?> PickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    print("Requesting photo permission...}");
    var permissionStatus = await Permission.photos.request();
    print("Permission status after request: $permissionStatus");
    var currentStatus = await Permission.photos.status;
    print("Current permission status: $currentStatus");

    if (currentStatus.isDenied) {
      print("Permission granted. Picking image...");
      final PickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (PickedImage != null) {
        print("Image picked successfully.");
        image = File(PickedImage.path);
        showSnackBar(
            message: 'Image picked successfully.',
            isError: false,
            isToaster: true);
      } else {
        print("No image picked.");
        showSnackBar(
            message: 'No image picked!', isError: true, isToaster: true);
      }
    } else {
      print("Permission denied.");
      showSnackBar(
          message: 'Permission denied.', isError: true, isToaster: true);
    }
  } catch (e) {
    print("Error: $e");
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(e.toString())));
  }
  return image;
}
