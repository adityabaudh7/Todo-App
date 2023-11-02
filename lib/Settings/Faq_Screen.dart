// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:taskplus/Theme/Color_plate.dart';

class FaqScreens extends StatelessWidget {
  const FaqScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FaqScreens'),
      ),
      body: ListView(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                color: ColorPalate.WHITE,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('aditya kumar'),
                          Text('aditya kumar'),
                          Text('aditya kumar'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 20,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          color: ColorPalate.BLACK,
                          height: constraints.biggest.height,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
