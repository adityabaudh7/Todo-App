// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:taskplus/Home/Profile_Settings_screen.dart';
import 'package:taskplus/Home/Stecky_Notes_Screen.dart';
import 'package:taskplus/Home/Task_Calender_Screen.dart';
import 'package:taskplus/Home/Todo_HomeScreen.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    final darkMode = ref.watch(darkModeProvider);
        List<PersistentBottomNavBarItem> _navBarItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.home, size: 22),
          title: "Home",
          // activeColorPrimary: Colors.blue,
          activeColorPrimary: ColorPalate.DARK_PRIMERY,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.solidCalendarDays, size: 22),
          title: "Calender",
          // activeColorPrimary: Colors.green,
          activeColorPrimary: ColorPalate.DARK_PRIMERY,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.solidNoteSticky, size: 22),
          title: "Notes",
          // activeColorPrimary: Colors.red,
          activeColorPrimary: ColorPalate.DARK_PRIMERY,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            FontAwesomeIcons.gear,
            size: 22,
          ),
          title: "Settings",

          // activeColorPrimary: Colors.orange,
          activeColorPrimary: ColorPalate.DARK_PRIMERY,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    PersistentTabView _buildBottomNavigation() {
      return PersistentTabView(
        context,
        controller: _controller,
        screens: [
          HomeScreen(),
          TaskCalenderScreen(),
          StickyNotesScreen(),
          ProfileSettingScreen(),
        ],
        items: _navBarItems(),
        backgroundColor: darkMode?Colors.black:Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
      );
    }


    return Scaffold(body: _buildBottomNavigation());
  }
}
