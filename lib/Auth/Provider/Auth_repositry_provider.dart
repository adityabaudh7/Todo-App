// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:taskplus/Auth/Common/Common_firebase_Store.dart';
import 'package:taskplus/Auth/Model/User_model.dart';
import 'package:taskplus/Custom/Widget/ShowCustomSnackbar.dart';
import 'package:taskplus/Dashboard/Todo_Dashboard.dart';
import 'package:taskplus/Screens/Todo_Welcome_Screen.dart';

final authRepoProvider = Provider((ref) => AuthRepo(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepo {
  late final FirebaseAuth auth;
  late final FirebaseFirestore firestore;
  AuthRepo({
    required this.auth,
    required this.firestore,
  });

  // for getUser Details
  Future<UserModel?> getCurrentUserData() async {
    final userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

// for user signin
  void SignInWithEmail(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Get.off(DashboardScreen(), transition: Transition.native);
      showSnackBar(
          message: 'You Logined successfully', isError: false, isToaster: true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        print('No user found for that email. Please try again later.');
        showSnackBar(
            message: ' An internal error has occurred. Please try again later.',
            isError: true);
      } else {
        print('FirebaseAuthException: ${e.code}');
        showSnackBar(
            message: "An unexpected error occurred. Please try again later.",
            isError: true);
        print(e);
      }
    }
  }

// for signOut
  void SignoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();

      showSnackBar(message: 'Logout !', isToaster: true, isError: true);
      Get.offAll(WelcomeScreen(), transition: Transition.leftToRightWithFade);
      print('User Logout successfully !');
    } catch (e) {
      print(e);
      showSnackBar(message: '$e', isError: true);
    }
  }

  // for Delete account
  void deleteUserAccount() async {
    try {
      final userDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser?.uid);
      await userDocRef.delete();
      await FirebaseAuth.instance.currentUser?.delete();
      Get.offAll(WelcomeScreen(), transition: Transition.leftToRightWithFade);

      showSnackBar(message: 'User Delete', isError: true, isToaster: true);
      print('Delete User account successfully !');
    } catch (e) {
      print(e);
      print('error');
      showSnackBar(message: e.toString(), isError: true);
    }
  }

  // for save user data
  void saveUserDataToFireBase({
    required String name,
    required String email,
    required String phoneNumber,
    required File? profilePic,
    required String password,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String photoUrl =
          'https://firebasestorage.googleapis.com/v0/b/todo-plus-c097a.appspot.com/o/userplus-removebg-preview.png?alt=media&token=7ece9e5d-07bc-461c-bd18-1b512ca65bfe&_gl=1*1r4ucs9*_ga*MjA0MjgwMDg2Ny4xNjg5NzMzNzcy*_ga_CW55HF8NVT*MTY5ODk5ODQ5OC4xMDkuMS4xNjk4OTk4NTE4LjQwLjAuMA..';

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = userCredential.user!.uid;

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStoreRepoProvider)
            .storeFieldToFirebase('profilePic/$uid', profilePic);
      }
      var User = UserModel(
          name: name,
          email: email,
          uid: uid,
          phoneNumber: phoneNumber,
          profilePic: photoUrl,
          password: password);
      await firestore.collection('users').doc(uid).set(User.toMap());
      Get.off(DashboardScreen(), transition: Transition.native);
      showSnackBar(message: 'You Registered successfully!', isError: false);
    } catch (e) {
      print(e);
      showSnackBar(message: e.toString(), isError: true);
    }
  }
  void updateUserData({
    required String name,
    required String email,
    required String phoneNumber,
    required File? profilePic,
    required String password,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String photoUrl =
          'https://firebasestorage.googleapis.com/v0/b/todo-plus-c097a.appspot.com/o/userplus-removebg-preview.png?alt=media&token=7ece9e5d-07bc-461c-bd18-1b512ca65bfe&_gl=1*1r4ucs9*_ga*MjA0MjgwMDg2Ny4xNjg5NzMzNzcy*_ga_CW55HF8NVT*MTY5ODk5ODQ5OC4xMDkuMS4xNjk4OTk4NTE4LjQwLjAuMA..';

      String uid = auth.currentUser!.uid;

      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStoreRepoProvider)
            .storeFieldToFirebase('profilePic/$uid', profilePic);
      }
      var user = UserModel(
          name: name,
          email: email,
          uid: uid,
          phoneNumber: phoneNumber,
          profilePic: photoUrl,
          password: password);
      await firestore.collection('users').doc(uid).update(
            user.toMap(),
          );
      print('User data updated successfully.');
    } catch (e) {
      print(e);
    }
  }

  void updateProfilePic({
    required File profilePic,
    required ProviderRef ref,
    required BuildContext context,
  }) async {
    try {
      String uid = auth.currentUser!.uid;

      String photoUrl = await ref
          .read(commonFirebaseStoreRepoProvider)
          .storeFieldToFirebase('profilePic/$uid', profilePic);

      await firestore.collection('users').doc(uid).update({
        'profilePic': photoUrl,
      });
      showSnackBar(
          message: 'Profile picture updated successfully !',
          isError: false,
          isToaster: true);
      print('Profile picture updated successfully.');
    } catch (e) {
      print(e);
    }
  }
}
