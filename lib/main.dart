import 'package:flutter/material.dart';
import 'package:hellogram/app/screens/array_widget/array_widget.dart';
import 'package:hellogram/app/screens/main_screen.dart';
import 'package:hellogram/app/utils/const.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      home: MainScreen(),
    );
  }
}
