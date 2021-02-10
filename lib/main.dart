import 'package:flutter/material.dart';
import 'package:hellogram/app/screens/array_widget/array_widget.dart';
import 'package:hellogram/app/screens/login/login_page.dart';
import 'package:hellogram/app/screens/main_screen.dart';
import 'package:hellogram/app/utils/const.dart';
import 'package:hellogram/app/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dynamic setPage = await _login();
  runApp(Home(setPage: setPage));
}

Future<bool> _login() async {
  bool page;
  SharedPrefs prefs = new SharedPrefs();
  SharedPreferences pref = await prefs.prefs;
  if (pref.getString("userIdPref") != null) {
    page = true;
  } else {
    page = false;
  }
  return page;
}

class Home extends StatelessWidget {
  var setPage;
  Home({this.setPage});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      home: (setPage) ? MainScreen() : LoginPage(),
    );
  }
}
