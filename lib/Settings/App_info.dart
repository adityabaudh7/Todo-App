import 'package:flutter/material.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppInfoScreen'),
      ),
      body: Center(
        child: Text('AppInfoScreen'),
      ),
    );
  }
}
