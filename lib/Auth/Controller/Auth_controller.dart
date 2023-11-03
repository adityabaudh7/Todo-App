import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/Auth/Model/User_model.dart';
import 'package:taskplus/Auth/Provider/Auth_repositry_provider.dart';

final authControllerProvider = Provider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthController(authRepository: authRepo, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepo authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signINWithEmail(
      {required BuildContext context,
      required String email,
      required String password}) {
    authRepository.SignInWithEmail(context, email, password);
  }

// for logout
  void LogoutUser() {
    authRepository.SignoutUser();
  }

// for delete account
  void DeleteUserAccount() {
    authRepository.deleteUserAccount();
  }

  void saveDatatoFirebase(BuildContext context, String name, String email,
      File? profilePic, String phone, String password) {
    authRepository.saveUserDataToFireBase(
        name: name,
        email: email,
        phoneNumber: phone,
        profilePic: profilePic,
        password: password,
        ref: ref,
        context: context);
  }

  void updateUser(BuildContext context, String name, String email,
      File? profilePic, String phone, String password) {
    authRepository.updateUserData(
        name: name,
        email: email,
        phoneNumber: phone,
        profilePic: profilePic,
        password: password,
        ref: ref,
        context: context);
  }

  void UpdateUserProfile(
   {required BuildContext context,
 required   File profilePic,}
  ) {
    authRepository.updateProfilePic(
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }
}
