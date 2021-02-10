import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hellogram/app/screens/login/body/login_body.dart';
import 'package:hellogram/app/screens/login/bottom/login_bottom.dart';

class LoginPage extends StatelessWidget {
  String register;
  LoginPage({this.register});
  @override
  Widget build(BuildContext context) {
    //WillPopScope is Block back button onWillpop in call method if return false is Block back and if return true to pop page.
    return WillPopScope(
      onWillPop: () async => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('Warning'),
          content: Text('Do you really want to exit'),
          actions: [
            FlatButton(
              child: Text('Yes'),
              // to exit app
              onPressed: () => SystemNavigator.pop(),
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(c, false),
            ),
          ],
        ),
      ),
      child: Scaffold(
        body: LoginBody(this.register),
        bottomNavigationBar: LoginBottom(),
      ),
    );
  }
}
