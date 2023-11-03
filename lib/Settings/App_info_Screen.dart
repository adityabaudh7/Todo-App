import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskplus/Settings/services/Model/AppInfo_Content_model.dart';
import 'package:taskplus/Theme/Color_plate.dart';
import 'package:taskplus/Theme/Utils/text_theme.dart';
import 'package:taskplus/features/Task/Repositry/Todo_Repositry.dart';

class AppInfoScreen extends ConsumerWidget {
  const AppInfoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    return Scaffold(
        backgroundColor: darkMode ? ColorPalate.black2 : ColorPalate.WHITE,
        appBar: AppBar(
          title: const Text(
            'AppInfo',
            style: titleHeader,
          ),
        ),
        body: Stack(
          children: [
            Positioned(
                bottom: -50,
                right: -80,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
                      shape: BoxShape.circle),
                  height: 200,
                  width: 200,
                )),
            Positioned(
                bottom: -80,
                right: 50,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorPalate.DARK_PRIMERY.withOpacity(0.1),
                      shape: BoxShape.circle),
                  height: 160,
                  width: 160,
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: AppInfo.length,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    children: [
                      Text(
                        AppInfo[index]!.title,
                        style: titleHeader,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppInfo[index]!.discription,
                        style: titilliumRegular,
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }
}
