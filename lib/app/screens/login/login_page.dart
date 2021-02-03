import 'package:flutter/material.dart';
import 'package:hellogram/app/screens/login/body/login_body.dart';
import 'package:hellogram/app/screens/login/bottom/login_bottom.dart';

class LoginPage extends StatelessWidget {
  String register;
  LoginPage(this.register);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(this.register),
      bottomNavigationBar: LoginBottom(),
    );
  }
}
