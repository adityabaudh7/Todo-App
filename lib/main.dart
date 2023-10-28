
// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/Auth/Controller/Auth_controller.dart';
import 'package:taskplus/BordingScreens/Boarding_Screen.dart';
import 'package:taskplus/Dashboard/Todo_Dashboard.dart';
import 'package:taskplus/Screens/Error/Error_Screen.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:get/get.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    return ProviderScope(
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme:
              //  darkMode ? ThemeData.dark() : ThemeData.light(),
              ThemeData(
            useMaterial3: true,
            colorScheme: darkMode
                ? ColorScheme.dark(
                    primary: ColorPalate.BLACK,
                  ).copyWith(background: ColorPalate.BLACK)
                : ColorScheme.light(
                    primary: ColorPalate.DARK_PRIMERY,
                  ),
          ).copyWith(
                  scaffoldBackgroundColor: ColorPalate.LITE_PRIMERY,
                  backgroundColor: ColorPalate.WHITE),
          home: ref.watch(userDataAuthProvider).when(
              data: (user) {
                if (user == null) {
                  return Boarding_Screen();
                }
                return DashboardScreen();
              },
              error: (err, trace) {
                return ErrorScreen(
                  error:
                      'Error occurred. Please try again later. ${err.toString()}',
                );
              },
              loading: () => Center(child: CircularProgressIndicator(),),)

          // Boarding_Screen(),
          ),
    );
  }
}
